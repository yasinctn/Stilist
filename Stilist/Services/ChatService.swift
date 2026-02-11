//
//  ChatService.swift
//  Stilist
//
//  Created by Yasin Cetin on 18.11.2024.
//

import Foundation
import Firebase
import FirebaseFirestore

protocol ChatServiceProtocol: AnyObject {
    func checkOrCreateChat(participants: [String]) async throws -> String
    func fetchChats(forUser userId: String) async throws -> [Chat]
    func addMessage(chatID: String, message: Message) async throws
    func fetchMessages(for chatId: String) async throws -> [Message]
}

final class ChatService: ChatServiceProtocol {

    private let db = Firestore.firestore()

    func checkOrCreateChat(participants: [String]) async throws -> String {
        let sortedParticipants = participants.sorted()

        let snapshot = try await db.collection("chats")
            .whereField("participants", isEqualTo: sortedParticipants)
            .getDocuments()

        if let existingChat = snapshot.documents.first {
            return existingChat.documentID
        }

        let chatID = UUID().uuidString
        let chatData: [String: Any] = [
            "id": chatID,
            "participants": sortedParticipants,
            "createdAt": FieldValue.serverTimestamp()
        ]

        try await db.collection("chats").document(chatID).setData(chatData)
        return chatID
    }

    func fetchChats(forUser userId: String) async throws -> [Chat] {
        let snapshot = try await db.collection("chats")
            .whereField("participants", arrayContains: userId)
            .getDocuments()

        var chats: [Chat] = []

        for doc in snapshot.documents {
            let data = doc.data()
            guard let participants = data["participants"] as? [String] else { continue }

            if let lastMessage = try? await fetchLastMessage(for: doc.documentID) {
                let chat = Chat(
                    id: doc.documentID,
                    participants: participants,
                    lastMessage: lastMessage.content,
                    lastMessageTimestamp: lastMessage.timestamp.description,
                    isUnread: !lastMessage.isRead
                )
                chats.append(chat)
            }
        }

        return chats
    }

    private func fetchLastMessage(for chatID: String) async throws -> Message {
        let snapshot = try await db.collection("chats").document(chatID).collection("messages")
            .order(by: "timestamp", descending: true)
            .limit(to: 1)
            .getDocuments()

        guard let document = snapshot.documents.first else {
            throw NSError(domain: "ChatService", code: 404, userInfo: [NSLocalizedDescriptionKey: "Mesaj bulunamadı."])
        }

        guard let message = parseMessage(from: document) else {
            throw NSError(domain: "ChatService", code: 500, userInfo: [NSLocalizedDescriptionKey: "Mesaj verisi dönüştürülemedi."])
        }

        return message
    }

    private func parseMessage(from document: QueryDocumentSnapshot) -> Message? {
        let data = document.data()

        guard
            let chatId = data["chatId"] as? String,
            let senderId = data["senderId"] as? String,
            let receiverId = data["receiverId"] as? String,
            let content = data["content"] as? String,
            let timestamp = (data["timestamp"] as? Timestamp)?.dateValue(),
            let isRead = data["isRead"] as? Bool
        else {
            return nil
        }

        return Message(
            id: document.documentID,
            chatId: chatId,
            senderId: senderId,
            receiverId: receiverId,
            content: content,
            timestamp: timestamp,
            isRead: isRead
        )
    }

    func addMessage(chatID: String, message: Message) async throws {
        guard let messageID = message.id else {
            throw NSError(domain: "ChatService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Mesaj ID'si bulunamadı."])
        }

        let messageData: [String: Any] = [
            "id": messageID,
            "chatId": message.chatId,
            "senderId": message.senderId,
            "receiverId": message.receiverId,
            "content": message.content,
            "timestamp": message.timestamp,
            "isRead": message.isRead
        ]

        try await db.collection("chats").document(chatID).collection("messages")
            .document(messageID).setData(messageData)
    }

    func fetchMessages(for chatId: String) async throws -> [Message] {
        let snapshot = try await db.collection("chats").document(chatId).collection("messages")
            .order(by: "timestamp", descending: false)
            .getDocuments()

        return snapshot.documents.compactMap { doc -> Message? in
            parseMessage(from: doc)
        }
    }
}
