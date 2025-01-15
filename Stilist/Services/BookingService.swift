//
//  BookingService.swift
//  Stilist
//
//  Created by Yasin Cetin on 24.11.2024.
//

import Foundation
import FirebaseFirestore

protocol BookingServiceProtocol {
    func fetchAppointments(userId: String, status: Status, completion: @escaping (Result<[Appointment], Error>) -> Void)
    func saveAppointment(_ appointment: Appointment, completion: @escaping (Error?) -> Void)
}

final class BookingService: BookingServiceProtocol {
    private let db = Firestore.firestore()
    
    func fetchAppointments(userId: String, status: Status, completion: @escaping (Result<[Appointment], Error>) -> Void) {
        db.collection("appointments")
            .whereField("userId", isEqualTo: userId)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching appointments: \(error.localizedDescription)")
                    completion(.failure(error))
                    return
                }
                guard let documents = snapshot?.documents else {
                    print("No documents found.")
                    completion(.success([]))
                    return
                }
                let appointments = documents.compactMap { doc -> Appointment? in
                    try? doc.data(as: Appointment.self)
                }
                completion(.success(appointments))
            }
    }

    
    func saveAppointment(_ appointment: Appointment, completion: @escaping (Error?) -> Void) {
        let appointmentData: [String: Any] = [
            "id" : appointment.id,
            "date" : appointment.date,
            "time" : appointment.time,
            "specialistId" : appointment.specialistId,
            "specialistName": appointment.specialistName,
            "userName" : appointment.userName,
            "userId" : appointment.userId,
            "status" : appointment.status.rawValue
        ]
        
        db.collection("appointments")
            .document(appointment.id).setData(appointmentData) { error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
         

}
