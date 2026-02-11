//
//  ChatsView.swift
//  Stilist
//
//  Created by Yasin Cetin on 16.11.2024.
//

import SwiftUI

struct ChatsView: View {
    
    @EnvironmentObject private var navigationViewModel: NavigationViewModel
    @EnvironmentObject private var authViewModel: AuthViewModel
    @EnvironmentObject private var chatViewModel: ChatViewModel
    
    var body: some View {
        
            NavigationStack {
                VStack {
                    HStack {
                        Text("Sohbetler")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Spacer()
                        
                        //arama
                        NavigationLink {
                            MessageView()
                                .environmentObject(MessageViewModel())
                                .environmentObject(authViewModel)
                                .environmentObject(chatViewModel)
                                .environmentObject(navigationViewModel)
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .font(.title2)
                                .padding(.horizontal)
                                .foregroundStyle(Color.primary)
                        }
                        
                        // yeni mesaj oluşturma (daha sonra eklenecek)
                        /*
                        NavigationLink {
                            MessageView()
                                .environmentObject(MessageViewModel())
                                .environmentObject(authViewModel)
                                .environmentObject(chatViewModel)
                                .environmentObject(navigationViewModel)
                        } label: {
                            Image(systemName: "square.and.pencil")
                                .font(.title2)
                                .foregroundStyle(Color.primary)
                        }
                        
                        */
                    }
                    .padding()
                    
                    
                    if chatViewModel.isLoading {
                        Spacer()
                        LoadingView()
                        Spacer()
                    } else if chatViewModel.chats.isEmpty {
                        Spacer()
                        VStack(spacing: 8) {
                            Image(systemName: "bubble.left.and.bubble.right")
                                .font(.largeTitle)
                                .foregroundColor(.secondary)
                            Text("Henüz sohbet yok")
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    } else {
                        List {
                            ForEach(chatViewModel.chats) { chat in
                                NavigationLink {
                                    MessageView(chat: chat)
                                        .environmentObject(MessageViewModel())
                                        .environmentObject(authViewModel)
                                        .environmentObject(chatViewModel)
                                        .environmentObject(navigationViewModel)
                                } label: {
                                    ChatCell(chat: chat)
                                }
                            }
                        }
                        .listStyle(PlainListStyle())
                    }
                    
                }
                .toolbar(.hidden, for: .navigationBar)
            }
            .onAppear {
                Task {
                    await chatViewModel.fetchChats(authViewModel.currentUser?.id)
                }
            }
            .errorAlert(message: $chatViewModel.errorMessage)
        
        
        
        
    }
}



// Sample Data

#Preview {
    ChatsView()
}
