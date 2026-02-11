//
//  BookingService.swift
//  Stilist
//
//  Created by Yasin Cetin on 24.11.2024.
//

import Foundation
import FirebaseFirestore

protocol BookingServiceProtocol {
    func fetchAppointments(userId: String) async throws -> [Appointment]
    func saveAppointment(_ appointment: Appointment) async throws
}

final class BookingService: BookingServiceProtocol {
    private let db = Firestore.firestore()

    func fetchAppointments(userId: String) async throws -> [Appointment] {
        let snapshot = try await db.collection("appointments")
            .whereField("userId", isEqualTo: userId)
            .getDocuments()

        return snapshot.documents.compactMap { doc in
            try? doc.data(as: Appointment.self)
        }
    }

    func saveAppointment(_ appointment: Appointment) async throws {
        let appointmentData: [String: Any] = [
            "id": appointment.id,
            "date": appointment.date,
            "time": appointment.time,
            "specialistId": appointment.specialistId,
            "specialistName": appointment.specialistName,
            "userName": appointment.userName,
            "userId": appointment.userId,
            "status": appointment.status.rawValue
        ]

        try await db.collection("appointments")
            .document(appointment.id).setData(appointmentData)
    }
}
