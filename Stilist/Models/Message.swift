//
//  Message.swift
//  Stilist
//
//  Created by Yasin Cetin on 16.11.2024.
//

import Foundation
import FirebaseFirestore

struct Message: Identifiable {
    
    let id: String?
    let chatId: String
    let senderId: String
    let receiverId: String
    let content: String
    let timestamp: Date
    let isRead: Bool
}
