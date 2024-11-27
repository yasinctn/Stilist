//
//  Specialist.swift
//  Stilist
//
//  Created by Yasin Cetin on 26.11.2024.
//

import Foundation
import FirebaseFirestore


struct Specialist: Identifiable, Codable {
    @DocumentID var id: String? // Firestore döküman kimliği
    var name: String // Uzman adı
    var role: String // Uzmanlık alanı (örneğin: "Sr. Barber", "Hair Stylist")
    var imageName: String // Profil resmi için kullanılacak resim adı veya URL
    var availability: [String] // Uzmanın uygun olduğu saatler (örneğin: ["09:00", "10:00", "11:00"])
}
