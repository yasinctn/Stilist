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
    
    @State var chat : Chat? 
    @State var messageText: String = ""
    @State var chatID: String? 
    @State var receiverID: String?
    @State var senderID: String?
    @State var barberName: String?
    
    var body: some View {
        
                VStack {
                    if messageViewModel.isLoading {
                        Spacer()
                        LoadingView()
                        Spacer()
                    } else {
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


                            // Gönderici ve alıcı bilgisi kontrolü
                            if senderID == nil || receiverID == nil {
                                // Gönderici veya alıcı bilgisi eksik
                            }

                            // Mesaj gönderme işlemi
                            if !messageText.isEmpty {
                                Task {
                                    await messageViewModel.sendMessage(senderId: senderID, receiverId: receiverID, messageText: messageText)

                                    guard let senderID, let receiverID else {
                                        return
                                    }
                                    await messageViewModel.getMessages(chatID: messageViewModel.chatID, participants: [senderID, receiverID])
                                }

                            }

                            // Mesaj metnini sıfırla
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
                .navigationTitle(barberName ?? "Mesajlar")
                .onAppear {
                    if let chat {
                        senderID = authViewModel.currentUser?.id
                        receiverID = chat.participants.first(where: { $0 != senderID })
                        chatID = chat.id
                        messageViewModel.chatID = chat.id
                    }
                    Task {
                        await messageViewModel.getMessages(chatID: chatID, participants: [senderID, receiverID])
                    }
                }
                .errorAlert(message: $messageViewModel.errorMessage)
            
        
    }
}
