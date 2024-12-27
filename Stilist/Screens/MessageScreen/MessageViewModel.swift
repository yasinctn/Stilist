//
//  MessageViewModel.swift
//  Stilist
//
//  Created by Yasin Cetin on 16.12.2024.
//

import Foundation

final class MessageViewModel: ObservableObject {
    
    @Published var messages: [Message] = []
    
    private var chatService: ChatServiceProtocol
    
    init(chatService: ChatServiceProtocol = ChatService()) {
        self.chatService = chatService
    }
}

extension MessageViewModel {
    
    func getMessages(chatID: String?, participants: [String]) {
            if let chatID {
                // Fetch messages directly if chatID is available
                chatService.fetchMessages(for: chatID) { error, messages in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        guard let messages else {
                            return print("No messages")
                        }
                        DispatchQueue.main.async {
                            self.messages = messages
                        }
                    }
                }
            } else {
                // Check or create chat based on participants
                chatService.checkOrCreateChat(participants: participants) { result in
                    switch result {
                    case .success(let id):
                        DispatchQueue.main.async {
                            self.getMessages(chatID: id, participants: participants)
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    
    func sendMessage(senderId: String, receiverId: String, messageText: String, chatID: String?) {
        if let chatID {
            let newMessage = Message(chatId: chatID,
                                     senderId: senderId,
                                     receiverId: receiverId,
                                     content: messageText,
                                     timestamp: Date(),
                                     isRead: false)

            chatService.addMessage(chatID: chatID, message: newMessage) { error in
                if let error {
                    print(error.localizedDescription)
                } else {
                    print("Mesaj gönderildi")
                    self.getMessages(chatID: chatID, participants: [senderId, receiverId])
                }
            }
        } else {
            chatService.checkOrCreateChat(participants: [senderId, receiverId]) { result in
                switch result {
                case .success(let id):
                    self.sendMessage(senderId: senderId, receiverId: receiverId, messageText: messageText, chatID: id)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
