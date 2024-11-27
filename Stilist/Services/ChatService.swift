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
    func addChat(_ chat: Chat, completion: @escaping (Result<Void, Error>) -> Void)
    func fetchChats(completion: @escaping (Result<[Chat], Error>) -> Void)
    func addMessage(_ message: Message, completion: @escaping (Result<Void, Error>) -> Void)
    func fetchMessages(for chatId: String, completion: @escaping (Result<[Message], Error>) -> Void)
}

final class ChatService: ChatServiceProtocol {
    
    private let db = Firestore.firestore()
    
    func addChat(_ chat: Chat, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let chatID = chat.id else {
            return
        }
        let chatData: [String: Any] = [
            "id": chatID,
            "participants": chat.participants,
            "lastMessage": chat.lastMessage,
            "lastMessageTimestamp": chat.lastMessageTimestamp,
            "isUnread": chat.isUnread,
            "profileImageName": chat.profileImageName
        ]
        
        db.collection("chats").document(chatID).setData(chatData) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func fetchChats(completion: @escaping (Result<[Chat], Error>) -> Void) {
        db.collection("chats").getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion(.success([]))
                return
            }
            
            let chats = documents.compactMap { doc -> Chat? in
                let data = doc.data()
                
                guard
                    let name = data["name"] as? String,
                    let participants = data["participants"] as? [String],
                    let lastMessage = data["lastMessage"] as? String,
                    let lastMessageTimestamp = data["lastMessageTimestamp"] as? String,
                    let isUnread = data["isUnread"] as? Bool,
                    let profileImageName = data["profileImageName"] as? String
                else { return nil }
                
                return Chat(
                    name: name,
                    participants: participants,
                    lastMessage: lastMessage,
                    lastMessageTimestamp: lastMessageTimestamp,
                    isUnread: isUnread,
                    profileImageName: profileImageName
                )
            }
            
            completion(.success(chats))
        }
    }
    
    func addMessage(_ message: Message, completion: @escaping (Result<Void, Error>) -> Void) {
        
        guard let messageID = message.id else {
            fatalError("Message ID must not be nil")
        }
        let messageData: [String: Any] = [
            "id": messageID,
            "chatId": message.chatId,
            "senderId": message.senderId,
            "content": message.content,
            "timestamp": message.timestamp,
            "isRead": message.isRead
        ]
        
        db.collection("messages").document(messageID).setData(messageData) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func fetchMessages(for chatId: String, completion: @escaping (Result<[Message], Error>) -> Void) {
        db.collection("messages")
            .whereField("chatId", isEqualTo: chatId)
            .order(by: "timestamp", descending: false)
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    completion(.success([]))
                    return
                }
                
                let messages = documents.compactMap { doc -> Message? in
                    let data = doc.data()
                    
                    guard
                        let chatId = data["chatId"] as? String,
                        let senderId = data["senderId"] as? String,
                        let content = data["content"] as? String,
                        let timestamp = (data["timestamp"] as? Timestamp)?.dateValue(),
                        let isRead = data["isRead"] as? Bool
                    else { return nil }
                    
                    return Message(
                        id: doc.documentID,
                        chatId: chatId,
                        senderId: senderId,
                        content: content,
                        timestamp: timestamp,
                        isRead: isRead
                    )
                }
                
                completion(.success(messages))
            }
    }
    
}
