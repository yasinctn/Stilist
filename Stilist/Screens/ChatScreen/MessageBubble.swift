//
//  MessageBubble.swift
//  Stilist
//
//  Created by Yasin Cetin on 23.11.2024.
//

import SwiftUI

struct MessageBubble: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var message: Message
    
    var body: some View {
        VStack(alignment: message.senderId == authViewModel.currentUser?.uid ? .trailing : .leading) {
            Text(message.content)
                .padding()
                .foregroundColor(message.senderId == authViewModel.currentUser?.uid ? .white : .black)
                .background(message.senderId == authViewModel.currentUser?.uid ? Color.orange : Color.gray.opacity(0.2))
                .cornerRadius(15)
            Text(message.timestamp.ISO8601Format())
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: 250, alignment: message.senderId == authViewModel.currentUser?.uid ? .trailing : .leading)
    }
}
