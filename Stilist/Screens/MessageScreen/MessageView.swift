//
//  MessageView.swift
//  Stilist
//
//  Created by Yasin Cetin on 21.11.2024.
//

import SwiftUI

struct MessageView: View {
    
    @EnvironmentObject private var navigationViewModel: NavigationViewModel
    @EnvironmentObject private var authViewModel: AuthViewModel
    @EnvironmentObject private var chatViewModel: ChatViewModel
    @EnvironmentObject private var messageViewModel: MessageViewModel
    
    @State var messageText: String = ""
    @State var chatID: String = ""
    @State var barberName: String = "By Tarık Demirci"
    
    /*
    @State private var messages: [Message] = [
        Message(id: UUID().uuidString, chatId: "1", senderId: "NpqKRtxcdHMWYiP4KsswGyWKHTW2", content: "Hi, good morning 😊", timestamp: Date(), isRead: true),
        Message(id: UUID().uuidString, chatId: "1", senderId: "NpqKRtxcdHMWYiP4KsswGyWKHTW2", content: "I saw your barber/salon, and I'm very interested in trying it.", timestamp: Date(), isRead: true),
        Message(id: UUID().uuidString, chatId: "1", senderId: "barber1", content: "Hi, sure.\nYou can come directly to our location according to our working hours", timestamp: Date(), isRead: true),
        Message(id: UUID().uuidString, chatId: "1", senderId: "barber1", content: "We also have the latest hairstyles, and I highly recommend them to you 😊", timestamp: Date(), isRead: true),
        Message(id: UUID().uuidString, chatId: "1", senderId: "NpqKRtxcdHMWYiP4KsswGyWKHTW2", content: "omg, this is amazing 👍", timestamp: Date(), isRead: true)
    ]
    */
    
    var body: some View {
        
                VStack {
                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(messageViewModel.messages) { message in
                                HStack {
                                    MessageBubble(message: message)
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    // Message Input
                    HStack {
                        TextField("", text: $messageText)
                            .textFieldStyle(.plain)
                            .lineLimit(0)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(20)
                            
                        Button(action: {
                                if let userID = authViewModel.currentUser?.uid, !messageText.isEmpty {
                                    
                                    messageViewModel.sendMessage(senderId: userID, messageText: messageText, chatID: chatID)
                                    messageViewModel.getMessages(chatID: chatID)
                                }
                            messageText = ""
                            
                        }) {
                            Image(systemName: "paperplane")
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.orange)
                                .clipShape(Circle())
                        }
                    }
                    .padding()
                }
                .navigationTitle(barberName)
                .onAppear {
                    messageViewModel.getMessages(chatID: chatID)
                }
            
        
    }
}
