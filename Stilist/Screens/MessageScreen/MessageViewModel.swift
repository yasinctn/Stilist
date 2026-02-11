//
//  MessageViewModel.swift
//  Stilist
//
//  Created by Yasin Cetin on 16.12.2024.
//

import Foundation

@MainActor
final class MessageViewModel: ObservableObject {

    @Published var messages: [Message] = []
    @Published var chatID: String?
    @Published var isLoading = false
    @Published var errorMessage: String?
    private var chatService: ChatServiceProtocol

    init(chatService: ChatServiceProtocol = ChatService()) {
        self.chatService = chatService
    }

    func getMessages(chatID: String?, participants: [String?]) async {
        let validParticipants = participants.compactMap { $0 }

        if let chatID = chatID {
            self.chatID = chatID
            isLoading = true
            do {
                self.messages = try await chatService.fetchMessages(for: chatID)
            } catch {
                self.errorMessage = "Mesajlar alınamadı: \(error.localizedDescription)"
            }
            isLoading = false
        } else {
            do {
                let newChatID = try await chatService.checkOrCreateChat(participants: validParticipants)
                self.chatID = newChatID
                await getMessages(chatID: newChatID, participants: validParticipants)
            } catch {
                self.errorMessage = "Sohbet oluşturulamadı: \(error.localizedDescription)"
            }
        }
    }

    func sendMessage(senderId: String?, receiverId: String?, messageText: String) async {
        guard let senderId, let receiverId else { return }

        isLoading = true
        let activeChatID: String
        if let chatID = self.chatID {
            activeChatID = chatID
        } else {
            do {
                activeChatID = try await chatService.checkOrCreateChat(participants: [senderId, receiverId])
                self.chatID = activeChatID
            } catch {
                self.errorMessage = "Sohbet oluşturulamadı: \(error.localizedDescription)"
                isLoading = false
                return
            }
        }

        let newMessage = Message(
            id: UUID().uuidString,
            chatId: activeChatID,
            senderId: senderId,
            receiverId: receiverId,
            content: messageText,
            timestamp: Date(),
            isRead: false
        )

        do {
            try await chatService.addMessage(chatID: activeChatID, message: newMessage)
            self.messages = try await chatService.fetchMessages(for: activeChatID)
        } catch {
            self.errorMessage = "Mesaj gönderilemedi: \(error.localizedDescription)"
        }
        isLoading = false
    }
}
