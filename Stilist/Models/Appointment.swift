//
//  Appointment.swift
//  Stilist
//
//  Created by Yasin Cetin on 26.11.2024.
//

import Foundation
import FirebaseFirestore

struct Appointment: Identifiable, Codable {
    
    var id: String = UUID().uuidString
    var date: Date
    var time: String
    var specialistId: String
    var specialistName: String
    var userName: String
    var userId: String
    var status: Status
}

