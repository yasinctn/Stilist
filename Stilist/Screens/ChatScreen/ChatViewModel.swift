//
//  ChatViewModel.swift
//  Stilist
//
//  Created by Yasin Cetin on 18.11.2024.
//

import Foundation
import SwiftUI

@MainActor
final class ChatViewModel: ObservableObject {

    @Published var chats: [Chat] = []
    @Published var createdChatID: String?
    @Published var isLoading = false
    @Published var errorMessage: String?
    private let chatService: ChatServiceProtocol?

    init(chatService: ChatServiceProtocol? = ChatService()) {
        self.chatService = chatService
    }

    func fetchChats(_ id: String?) async {
        guard let id else { return }
        isLoading = true
        do {
            self.chats = try await chatService?.fetchChats(forUser: id) ?? []
        } catch {
            self.errorMessage = "Sohbetler alınamadı: \(error.localizedDescription)"
        }
        isLoading = false
    }
}
