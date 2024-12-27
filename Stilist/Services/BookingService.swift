//
//  BookingService.swift
//  Stilist
//
//  Created by Yasin Cetin on 24.11.2024.
//

import Foundation
import FirebaseFirestore

protocol BookingServiceProtocol {
    func fetchAppointments(for userId: String, status: Status, completion: @escaping (Result<[Appointment], Error>) -> Void)
    func saveAppointment(_ appointment: Appointment, completion: @escaping (Error?) -> Void)
}

final class BookingService: BookingServiceProtocol {
    private let db = Firestore.firestore()
    
    func fetchAppointments(for userId: String, status: Status, completion: @escaping (Result<[Appointment], Error>) -> Void) {
        db.collection("appointments")
            .whereField("userId", isEqualTo: userId)
            .whereField("status", isEqualTo: status.rawValue)
            .order(by: "date", descending: false)
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let documents = snapshot?.documents else {
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
        
        guard let id = appointment.id else {
            completion(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid Appointment ID"]))
            return
        }
        
        do {
            try db.collection("appointments").document(id).setData(from: appointment, merge: true, completion: completion)
        } catch {
            completion(error)
        }
    }
}
