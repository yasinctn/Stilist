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
    
    func getMessages(chatID: String?) {
        
        if let chatID {
            chatService.fetchMessages(for: chatID) { error, messages in
                if let error = error {
                    print(error.localizedDescription)
                }else {
                    guard let messages else {
                        return print("No messages")
                    }
                    DispatchQueue.main.async {
                        self.messages = messages
                    }
                }
            }
        }
    }
    
    func sendMessage(senderId:String, messageText: String, chatID: String) {
        let newMessage = Message(chatId: chatID,
                                 senderId: senderId,
                                 content: messageText,
                                 timestamp: Date(),
                                 isRead: false)
        chatService.addMessage(newMessage) { error in
            if let error {
                print(error.localizedDescription)
            }else {
                print("mesaj gönderildi")
                self.getMessages(chatID: chatID)
            }
                
        }
    }
}
