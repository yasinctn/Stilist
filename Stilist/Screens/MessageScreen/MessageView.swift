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
    @State var chatID: String? 
    @State var receiverID: String?
    @State var senderID: String?
    @State var barberName: String?
    
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
                            if let senderID, !messageText.isEmpty, let receiverID {
                                    
                                messageViewModel.sendMessage(senderId: senderID, receiverId: receiverID, messageText: messageText, chatID: chatID)
                                    
                                messageViewModel.getMessages(chatID: chatID, participants: [senderID, receiverID])
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
                .navigationTitle(barberName ?? "loading")
                .onAppear {
                    guard let senderID, let receiverID else { return }
                    messageViewModel.getMessages(chatID: chatID, participants: [senderID, receiverID])
                }
            
        
    }
}
