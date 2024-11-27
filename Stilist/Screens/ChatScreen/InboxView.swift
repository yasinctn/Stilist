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
        NavigationStack(path: $navigationViewModel.inboxPath) {
            VStack {
                HStack {
                    Text("Inbox")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                    
                    Button {
                        navigationViewModel.navigate("message")
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .font(.title2)
                            .padding(.horizontal)
                            .foregroundStyle(Color.black)
                    }

                    
                    Button {
                        navigationViewModel.navigate("message")
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .font(.title2)
                            .foregroundStyle(Color.black)
                    }
                }
                .padding()
                
                
                List {
                    ForEach(sampleChats) { chat in
                        ChatCell(chat: chat)
                    }
                }
                .listStyle(PlainListStyle())
                
            }
            .navigationBarHidden(true)
            .navigationDestination(for: String.self) { destination in
                switch destination {
                case "message":
                    MessageView()
                        .environmentObject(authViewModel)
                        .environmentObject(chatViewModel)
                        .environmentObject(navigationViewModel)
                default:
                    EmptyView()
                }
            }
        }
        
        
        
    }
}



// Sample Data
let sampleChats: [Chat] = [
    Chat(
        name: "Ahmet Yıldırım",
        participants: ["user1", "user2"],
        lastMessage: "Merhaba! Yarınki randevunuz için detayları konuşmak ister misiniz?",
        lastMessageTimestamp: "2023-11-15 14:23",
        isUnread: true,
        profileImageName: "profile_ahmet"
    ),
    Chat(
        name: "Mehmet Can",
        participants: ["user1", "user3"],
        lastMessage: "Görüşmek üzere, iyi günler!",
        lastMessageTimestamp: "2023-11-15 09:17",
        isUnread: false,
        profileImageName: "profile_mehmet"
    ),
    Chat(
        name: "Barber Shop",
        participants: ["user1", "user4"],
        lastMessage: "Rezervasyonunuz onaylandı. 17 Kasım'da bekliyoruz.",
        lastMessageTimestamp: "2023-11-14 18:30",
        isUnread: true,
        profileImageName: "profile_barbershop"
    ),
    Chat(
        name: "Fatma Akın",
        participants: ["user1", "user5"],
        lastMessage: "Saat 10 uygun mu?",
        lastMessageTimestamp: "2023-11-13 11:45",
        isUnread: false,
        profileImageName: "profile_fatma"
    ),
    Chat(
        name: "Ali Karaca",
        participants: ["user1", "user6"],
        lastMessage: "Son olarak saç kesimini onaylayayım mı?",
        lastMessageTimestamp: "2023-11-12 08:20",
        isUnread: true,
        profileImageName: "profile_ali"
    )
]
#Preview {
    InboxView()
}
