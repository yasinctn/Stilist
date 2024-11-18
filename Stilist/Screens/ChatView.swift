//
//  ChatView.swift
//  Stilist
//
//  Created by Yasin Cetin on 18.11.2024.
//

import SwiftUI

struct ChatView: View {
    @State private var messages: [Message] = [
        Message(id: UUID().uuidString, chatId: "1", senderId: "user1", content: "Hi, good morning 😊", timestamp: Date(), isRead: true),
        Message(id: UUID().uuidString, chatId: "1", senderId: "user1", content: "I saw your barber/salon, and I'm very interested in trying it.", timestamp: Date(), isRead: true),
        Message(id: UUID().uuidString, chatId: "1", senderId: "barber1", content: "Hi, sure.\nYou can come directly to our location according to our working hours", timestamp: Date(), isRead: true),
        Message(id: UUID().uuidString, chatId: "1", senderId: "barber1", content: "We also have the latest hairstyles, and I highly recommend them to you 😊", timestamp: Date(), isRead: true),
        Message(id: UUID().uuidString, chatId: "1", senderId: "user1", content: "omg, this is amazing 👍", timestamp: Date(), isRead: true)
    ]
    
    @State private var messageText: String = ""
    
    var body: some View {
        VStack {
            // Header
            HStack {
                Button(action: { /* back action */ }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                Text("The Barber Show")
                    .font(.headline)
                
                Spacer()
                
                HStack(spacing: 20) {
                    Image(systemName: "phone.fill")
                    Image(systemName: "video.fill")
                }
                .foregroundColor(.black)
            }
            .padding()
            .background(Color.white)
            
            Divider()
            
            // Messages List
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(messages) { message in
                        MessageBubble(message: message)
                    }
                }
                .padding(.horizontal)
            }
            .background(Color(UIColor.systemGray6))
            
            // Message Input
            HStack {
                TextField("Message...", text: $messageText)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                
                Button(action: {
                    sendMessage()
                }) {
                    Image(systemName: "mic.fill")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.orange)
                        .clipShape(Circle())
                }
            }
            .padding()
        }
    }
    
    func sendMessage() {
        if !messageText.isEmpty {
            let newMessage = Message(
                id: UUID().uuidString,
                chatId: "1",
                senderId: "user1",
                content: messageText,
                timestamp: Date(),
                isRead: false
            )
            messages.append(newMessage)
            messageText = ""
        }
    }
}

// Message Bubble
struct MessageBubble: View {
    var message: Message
    var isCurrentUser: Bool {
        message.senderId == "user1" // Adjust based on the current user's ID
    }
    
    var body: some View {
        HStack {
            if isCurrentUser {
                Spacer()
                Text(message.content)
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .frame(maxWidth: 250, alignment: .leading)
                Text(formattedTime(for: message.timestamp))
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.leading, 8)
            } else {
                Text(formattedTime(for: message.timestamp))
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.trailing, 8)
                Text(message.content)
                    .padding()
                    .background(Color(UIColor.systemGray5))
                    .foregroundColor(.black)
                    .cornerRadius(15)
                    .frame(maxWidth: 250, alignment: .leading)
                Spacer()
            }
        }
        .padding(isCurrentUser ? .leading : .trailing, 50)
    }
    
    private func formattedTime(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
