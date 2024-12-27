//
//  InboxView.swift
//  Stilist
//
//  Created by Yasin Cetin on 16.11.2024.
//

import SwiftUI

struct InboxView: View {
    
    @EnvironmentObject private var navigationViewModel: NavigationViewModel
    @EnvironmentObject private var authViewModel: AuthViewModel
    @EnvironmentObject private var chatViewModel: ChatViewModel
    
    var body: some View {
        
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
                
                
                List {
                    ForEach(chatViewModel.chats) { chat in
                        NavigationLink {
                            MessageView(chatID: chat.id)
                        } label: {
                            ChatCell(chat: chat)
                        }

                        
                    }
                }
                .listStyle(PlainListStyle())
                
            }
            .navigationBarHidden(true)
            .onAppear {
                chatViewModel.fetchChats()
            }
        
        
        
        
    }
}



// Sample Data
let sampleChats: [Chat] = [
    Chat(
        
        participants: ["user1", "user2"],
        lastMessage: "Merhaba! Yarınki randevunuz için detayları konuşmak ister misiniz?",
        lastMessageTimestamp: "2023-11-15 14:23",
        isUnread: true
        
    ),
    Chat(
        
        participants: ["user1", "user3"],
        lastMessage: "Görüşmek üzere, iyi günler!",
        lastMessageTimestamp: "2023-11-15 09:17",
        isUnread: false
        
    ),
    Chat(
        
        participants: ["user1", "user4"],
        lastMessage: "Rezervasyonunuz onaylandı. 17 Kasım'da bekliyoruz.",
        lastMessageTimestamp: "2023-11-14 18:30",
        isUnread: true
        
    ),
    Chat(
        
        participants: ["user1", "user5"],
        lastMessage: "Saat 10 uygun mu?",
        lastMessageTimestamp: "2023-11-13 11:45",
        isUnread: false
        
    ),
    Chat(
        
        participants: ["user1", "user6"],
        lastMessage: "Son olarak saç kesimini onaylayayım mı?",
        lastMessageTimestamp: "2023-11-12 08:20",
        isUnread: true
        
    )
]
#Preview {
    InboxView()
}
