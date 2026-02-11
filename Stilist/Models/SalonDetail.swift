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
    var workingHours: [WorkingHours]?
    var services: [Service]?
    var reviews: [Review]?
    var latitude: Double?
    var longitude: Double?
}

struct WorkingHours: Codable, Identifiable {
    var id: String { day ?? UUID().uuidString }
    let day: String?
    let openTime: String?
    let closeTime: String?
}

struct Service: Identifiable, Codable {
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
