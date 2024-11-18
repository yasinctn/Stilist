//
//  ChatCell.swift
//  Stilist
//
//  Created by Yasin Cetin on 16.11.2024.
//

import SwiftUI

struct ChatCell: View {
    
    @State var chat: Chat
    
    var body: some View {
        HStack {
            // Profil Resmi
            Image(chat.profileImageName)
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            // Sohbet Detayları
            VStack(alignment: .leading, spacing: 4) {
                Text(chat.name)
                    .font(.headline)
                Text(chat.lastMessage)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
            
            Spacer()
            
            // Zaman ve Okunmamış Mesaj Göstergesi
            VStack {
                Text(chat.lastMessageTimestamp)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                if chat.isUnread {
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.blue)
                }
            }
        }
        .padding(7)
    }
    
}

#Preview {
    ChatCell(chat: Chat(name: "yasin", participants: ["yasin", "ufuk"], lastMessage: "merhaba", lastMessageTimestamp: "12.4", isUnread: true, profileImageName: "deneme"))
}
