//
//  Specialist.swift
//  Stilist
//
//  Created by Yasin Cetin on 26.11.2024.
//

import Foundation
import FirebaseFirestore


struct Specialist: Identifiable, Codable {
    let id: String?
    let name: String?
    let expertise: String?
    let imageName: String?
    let unavailability: [Unavailability]?
}

struct Unavailability: Identifiable, Codable {
    var id: String?
    var date: Date?
    var hours: [String]?
    
}
