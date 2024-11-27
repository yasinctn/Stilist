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
    
    @State var messageText: String = ""
    @State var chatID: String = ""
    @State var barberName: String = "By Tarık Demirci"
    
    var body: some View {
        
        
                VStack {
                    
                    // Messages
                    let messages = chatViewModel.fetchMessages(chatId: chatID) ?? []

                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(messages) { message in
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
                            // Add new message
                            
                                if let userID = authViewModel.currentUser?.uid, !messageText.isEmpty {
                                    let newMessage = Message(chatId: chatID,
                                                             senderId: userID,
                                                             content: messageText,
                                                             timestamp: Date(),
                                                             isRead: false)
                                    chatViewModel.sendMessage(message: newMessage)
                                }
                            
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
                .background(Color.white)
                .navigationTitle(barberName)
                
            
        
    }
}
