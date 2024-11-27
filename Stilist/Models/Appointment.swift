//
//  Appointment.swift
//  Stilist
//
//  Created by Yasin Cetin on 26.11.2024.
//

import Foundation
import FirebaseFirestore

struct Appointment: Identifiable, Codable {
    
    @DocumentID var id: String?
    var date: Date
    var time: String
    var specialistId: String
    var userId: String
}
