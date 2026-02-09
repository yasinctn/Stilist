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
    
    @Published var chats : [Chat] = []
    @Published var createdChatID: String?
    @Published var isLoading = false
    private let chatService: ChatServiceProtocol?
    
    
    init(chatService: ChatServiceProtocol? = ChatService(), authViewModel: AuthViewModel = .init()) {
        self.chatService = chatService
    }
    
    func fetchChats(_ id: String?)  {
        guard let id else { return }
        isLoading = true
        chatService?.fetchChats(forUser: id, completion: { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case.success(let chats):
                    self.chats = chats
                case .failure( let error):
                    print(error.localizedDescription)
                }
            }
        })
    }
    
    
    
}
