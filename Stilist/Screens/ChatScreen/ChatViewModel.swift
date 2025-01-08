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
    private let chatService: ChatServiceProtocol?
    
    
    init(chatService: ChatServiceProtocol?, authViewModel: AuthViewModel = .init()) {
        self.chatService = chatService
    }
    
    func fetchChats()  {
        chatService?.fetchChats(forUser: AuthViewModel().currentUser?.uid ?? "", completion: { result in
            switch result {
            case.success(let chats):
                print(chats)
                DispatchQueue.main.async {
                    self.chats = chats
                }
            case .failure( let error):
                print(error.localizedDescription)
            }
        })
    }
    
    
    
}
