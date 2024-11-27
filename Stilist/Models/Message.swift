//
//  Message.swift
//  Stilist
//
//  Created by Yasin Cetin on 16.11.2024.
//

import Foundation
import FirebaseFirestore

struct Message: Identifiable {
    
    @DocumentID var id: String?
    var chatId: String
    var senderId: String
    var content: String
    var timestamp: Date
    var isRead: Bool
}
