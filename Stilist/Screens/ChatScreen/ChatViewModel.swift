//
//  ChatViewModel.swift
//  Stilist
//
//  Created by Yasin Cetin on 18.11.2024.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreCombineSwift
import SwiftUI

final class ChatViewModel: ObservableObject {
    
    private let chatService: ChatServiceProtocol?
    @EnvironmentObject var authService: AuthService
    
    init(chatService: ChatServiceProtocol?) {
        self.chatService = chatService
    }
    
    func fetchChats() -> [Chat]  {
        var chats : [Chat] = []
        chatService?.fetchChats(completion: { result in
            
            do {
                try chats = result.get()
            } catch {
                print("chatError")
            }
        })
        return chats
    }
    
    func createChat() {
    }
    
    func sendMessage(message: Message?) {
        
        if let message {
            chatService?.addMessage(message, completion: { result in
                
                
            })
        }
    }
}
