//
//  SaloonDetail.swift
//  Stilist
//
//  Created by Yasin Cetin on 27.11.2024.
//

import Foundation

struct SaloonDetail {
    
    let id: String
    let name: String
    let address: String
    let phoneNumber: String
    let rating: Double
    let reviewCount: Int
    let isOpen: Bool
    
    // Çalışma Saatleri
    let workingHours: [WorkingHours] // Haftanın günlerine göre çalışma saatleri
    
    // Hizmetler
    let services: [Service]
    
    // Paketler
    let packages: [Package]
    
    // Galeri
    let gallery: [String] // Görsel URL'leri
    
    // İncelemeler
    let reviews: [Review]
}

struct WorkingHours {
    let day: String // Örneğin: "Monday"
    let openTime: String // Örneğin: "08:00 AM"
    let closeTime: String // Örneğin: "09:00 PM"
}

// Hizmet Yapısı
struct Service {
    let id: String
    let name: String
    let typeCount: Int // Örneğin: "44 types"
}

// Paket Yapısı
struct Package {
    let id: String
    let name: String
    let description: String
    let price: Double
    let validity: String // Örneğin: "Valid until Dec 10, 2024"
}

// İnceleme Yapısı
struct Review {
    let id: String
    let reviewerName: String
    let profileImageURL: String // Profil fotoğrafı URL'si
    let rating: Double
    let comment: String
    let timeAgo: String // Örneğin: "2 months ago"
}
