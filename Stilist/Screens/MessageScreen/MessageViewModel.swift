//
//  MessageViewModel.swift
//  Stilist
//
//  Created by Yasin Cetin on 16.12.2024.
//

import Foundation

final class MessageViewModel: ObservableObject {
    
    @Published var messages: [Message] = []
    @Published var isLoading = false
    private var chatService: ChatServiceProtocol
    
    init(chatService: ChatServiceProtocol = ChatService()) {
        self.chatService = chatService
    }
}

extension MessageViewModel {
    
    func getMessages(chatID: String?, participants: [String?]) {
        let validParticipants = participants.compactMap { $0 }

        if let chatID = chatID {
            DispatchQueue.main.async { self.isLoading = true }
            chatService.fetchMessages(for: chatID) { error, messages in
                DispatchQueue.main.async {
                    self.isLoading = false
                    if let error = error {
                        print("Error fetching messages: \(error.localizedDescription)")
                    } else {
                        guard let messages = messages else { return }
                        self.messages = messages
                    }
                }
            }
        } else {
            print(validParticipants)
            chatService.checkOrCreateChat(participants: validParticipants) { result in
                switch result {
                case .success(let newChatID):
                    self.getMessages(chatID: newChatID, participants: validParticipants)
                case .failure(let error):
                    print("Error creating or checking chat: \(error.localizedDescription)")
                }
            }
        }
    }

    func sendMessage(senderId: String?, receiverId: String?, messageText: String, chatID: String?) {
        guard let senderId, let receiverId else { return }
        if let chatID {
            print(chatID)
            let newMessage = Message(id: UUID().uuidString,
                                     chatId: chatID,
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
