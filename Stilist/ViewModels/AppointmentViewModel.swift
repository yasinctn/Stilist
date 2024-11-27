//
//  AppointmentViewModel.swift
//  Stilist
//
//  Created by Yasin Cetin on 26.11.2024.
//

import Foundation
import SwiftUI
import Firebase

class AppointmentViewModel: ObservableObject {
    @Published var selectedDate: Date = Date()
    @Published var selectedTime: String = ""
    @Published var selectedSpecialistId: String = ""
    @Published var specialists: [Specialist] = []

    init() {
        fetchSpecialists()
    }

    func fetchSpecialists() {
        // Firebase'den uzman verilerini alıp `specialists` dizisine atayın
    }

    func saveAppointment(userId: String) {
        let db = Firestore.firestore()
        let newAppointment = Appointment(date: selectedDate, time: selectedTime, specialistId: selectedSpecialistId, userId: userId)
        
        do {
            try db.collection("appointments").addDocument(from: newAppointment)
            print("Randevu başarıyla kaydedildi")
        } catch {
            print("Randevu kaydedilemedi: \(error.localizedDescription)")
        }
    }
}
