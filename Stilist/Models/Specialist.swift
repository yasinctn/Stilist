//
//  Specialist.swift
//  Stilist
//
//  Created by Yasin Cetin on 26.11.2024.
//

import Foundation
import FirebaseFirestore


struct Specialist: Identifiable, Codable {
    var id: UUID?
    var name: String?
    var expertise: String?
    var imageName: String?
    var unavailability: [Unavailability]?
}

struct Unavailability: Identifiable, Codable {
    var id: String?
    var date: Date?
    var hours: [String]?
    
}
