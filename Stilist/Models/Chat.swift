//
//  Chat.swift
//  Stilist
//
//  Created by Yasin Cetin on 16.11.2024.
//

import Foundation
import FirebaseFirestore

struct Chat: Identifiable {
    
    let id: String?
    let participants: [String]
    let lastMessage: String
    let lastMessageTimestamp: String
    let isUnread: Bool
    
}




