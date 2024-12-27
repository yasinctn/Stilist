//
//  Chat.swift
//  Stilist
//
//  Created by Yasin Cetin on 16.11.2024.
//

import Foundation
import FirebaseFirestore

struct Chat: Identifiable {
    
    var id: String? = UUID().uuidString
    var participants: [String]
    var lastMessage: String
    var lastMessageTimestamp: String
    var isUnread: Bool
    
}




