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
    var isCurrentUser: Bool {
        message.senderId == authViewModel.currentUser?.id
    }
    
    var body: some View {
        HStack {
            if isCurrentUser {
                Spacer()
                VStack(alignment: .trailing) {
                    Text(message.content)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .frame(maxWidth: 250, alignment: .trailing)
                    Text(formattedTime(for: message.timestamp))
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.leading, 8)
                }
            } else {
                VStack(alignment: .leading) {
                    Text(message.content)
                        .padding()
                        .background(Color(UIColor.systemGray4))
                        .foregroundColor(.black)
                        .cornerRadius(15)
                        .frame(maxWidth: 250, alignment: .leading)
                    Text(formattedTime(for: message.timestamp))
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.trailing, 8)
                }
                Spacer()
            }
        }
        
    }
    
    private func formattedTime(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}
