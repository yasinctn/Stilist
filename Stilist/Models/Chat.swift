//
//  Chat.swift
//  Stilist
//
//  Created by Yasin Cetin on 16.11.2024.
//

import Foundation
import FirebaseFirestore

struct Chat: Identifiable {
    
    var id: String?
    let name: String
    var participants: [String]
    let lastMessage: String
    var lastMessageTimestamp: String
    let isUnread: Bool
    let profileImageName: String
    
}




