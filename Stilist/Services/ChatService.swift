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
    func checkOrCreateChat(participants: [String], completion: @escaping (Result<String, Error>) -> Void)
    func fetchChats(forUser userId: String, completion: @escaping (Result<[Chat], Error>) -> Void)
    func addMessage(chatID: String, message: Message, completion: @escaping (Error?) -> Void)
    func fetchMessages(for chatId: String, completion: @escaping (Error?, [Message]?) -> Void)
}

final class ChatService: ChatServiceProtocol {
    
    private let db = Firestore.firestore()
    
    
    func checkOrCreateChat(participants: [String], completion: @escaping (Result<String, Error>) -> Void) {
        let sortedParticipants = participants.sorted()

        db.collection("chats").whereField("participants", isEqualTo: sortedParticipants).getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let querySnapshot = querySnapshot, !querySnapshot.documents.isEmpty {
                if let existingChat = querySnapshot.documents.first {
                    let chatID = existingChat.documentID
                    completion(.success(chatID))
                }
            } else {
                let chatID = UUID().uuidString

                let chatData: [String: Any] = [
                    "id": chatID,
                    "participants": sortedParticipants,
                    "createdAt": FieldValue.serverTimestamp() // Optional: add timestamp
                ]

                self.db.collection("chats").document(chatID).setData(chatData) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(chatID))
                    }
                }
            }
        }
    }

    func fetchChats(forUser userId: String, completion: @escaping (Result<[Chat], Error>) -> Void) {
        db.collection("chats")
            .whereField("participants", arrayContains: userId)
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let documents = snapshot?.documents else {
                    completion(.success([]))
                    print("No documents found")
                    return
                }

                let group = DispatchGroup()
                var chats: [Chat] = []

                for doc in documents {
                    group.enter()

                    let data = doc.data()
                    guard let participants = data["participants"] as? [String] else {
                        print("Participants field missing in: \(doc.data())")
                        group.leave()
                        continue
                    }

                    self.fetchLastMessage(for: doc.documentID) { result in
                        switch result {
                        case .success(let lastMessage):
                            let chat = Chat(
                                id: doc.documentID,
                                participants: participants,
                                lastMessage: lastMessage.content,
                                lastMessageTimestamp: lastMessage.timestamp.description,
                                isUnread: !lastMessage.isRead
                            )
                            chats.append(chat)
                        case .failure(let error):
                            print("Error fetching last message: \(error.localizedDescription)")
                        }
                        group.leave()
                    }
                }

                group.notify(queue: .main) {
                    completion(.success(chats))
                }
            }
    }

    private func fetchLastMessage(for chatID: String, completion: @escaping (Result<Message, Error>) -> Void) {
        db.collection("chats").document(chatID).collection("messages")
            .order(by: "timestamp", descending: true)
            .limit(to: 1)
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let document = snapshot?.documents.first else {
                    completion(.failure(NSError(domain: "ChatService", code: 404, userInfo: [NSLocalizedDescriptionKey: "No messages found"])))
                    return
                }

                if let message = self.parseMessage(from: document) {
                    completion(.success(message))
                } else {
                    completion(.failure(NSError(domain: "ChatService", code: 500, userInfo: [NSLocalizedDescriptionKey: "Invalid message data"])))
                }
            }
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
            print("Invalid message data: \(data)")
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

    
    func addMessage(chatID: String, message: Message, completion: @escaping (Error?) -> Void) {
        
        guard let messageID = message.id else {
            fatalError("Message ID must not be nil")
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
        
        
        
        db.collection("chats").document(chatID).collection("messages").document(messageID).setData(messageData) { error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
    

    func fetchMessages(for chatId: String, completion: @escaping (Error?, [Message]?) -> Void) {
            let chatRef = self.db.collection("chats").document(chatId).collection("messages")
            
            chatRef
                .order(by: "timestamp", descending: false)
                .getDocuments { snapshot, error in
                    if let error = error {
                        completion(error, nil)
                        return
                    }
                    
                    guard let documents = snapshot?.documents else {
                        completion(nil, nil)
                        return
                    }
                    
                    let messages = documents.compactMap { doc -> Message? in
                        let data = doc.data()
                        
                        guard
                            let chatId = data["chatId"] as? String,
                            let senderId = data["senderId"] as? String,
                            let receiverId = data["receiverId"] as? String,
                            let content = data["content"] as? String,
                            let timestamp = (data["timestamp"] as? Timestamp)?.dateValue(),
                            let isRead = data["isRead"] as? Bool
                        else { print("dönüştürülemedi");return nil }
                        
                        return Message(
                            id: doc.documentID,
                            chatId: chatId,
                            senderId: senderId,
                            receiverId: receiverId,
                            content: content,
                            timestamp: timestamp,
                            isRead: isRead
                        )
                    }
                    completion(nil, messages)
                }
        
    }
    
}
