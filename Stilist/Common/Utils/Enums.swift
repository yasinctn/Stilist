//
//  Enums.swift
//  Stilist
//
//  Created by Yasin Cetin on 7.12.2024.
//

import Foundation

enum UserRole: String, Codable {
    case admin = "admin"
    case customer = "customer"
    case specialist = "specialist"
}

enum Status: String, Codable {
    case upcoming = "upcoming"
    case completed = "completed"
    case cancelled = "cancelled"
}

enum Tab {
    case home, explore, myBooking, inbox, profile
}
