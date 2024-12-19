//
//  SalonDetail.swift
//  Stilist
//
//  Created by Yasin Cetin on 27.11.2024.
//

import Foundation

struct SalonDetail: Codable {
    var id: String?
    var name: String?
    var address: String?
    var phoneNumber: String?
    var description: String?
    var saloonType: String?
    var rating: String?
    var reviewCount: Int?
    var isOpen: Bool?
    var specialists: [Specialist]?
    var workingHours: [WorkingHours]? // Haftanın günlerine göre çalışma saatleri
    var services: [Service]?
    var reviews: [Review]?
    var latitude: Double?
    var longitude: Double?
}

struct WorkingHours: Codable {
    let day: String? // Örneğin: "Monday"
    let openTime: String? // Örneğin: "08:00 AM"
    let closeTime: String? // Örneğin: "09:00 PM"
}

struct Service:Identifiable, Codable {
    let id: String?
    let name: String?
    let description: String?
    let price: Double?
}

struct Review: Codable, Identifiable {
    let id: String?
    let reviewerName: String?
    let profileImageURL: String?
    let rating: Double?
    let comment: String?
    let timeAgo: String?
}
