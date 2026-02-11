//
//  AppointmentViewModel.swift
//  Stilist
//
//  Created by Yasin Cetin on 26.11.2024.
//

import Foundation
import SwiftUI

@MainActor
class AppointmentViewModel: ObservableObject {

    @Published var specialists: [Specialist] = []
    @Published var appointments: [Appointment] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let bookingService: BookingServiceProtocol
    private let firestoreService: FirestoreServiceProtocol

    init(bookingService: BookingServiceProtocol = BookingService(), firestoreService: FirestoreServiceProtocol = FirestoreService()) {
        self.bookingService = bookingService
        self.firestoreService = firestoreService
    }

    func fetchSpecialists(salonId: String) async {
        isLoading = true
        do {
            self.specialists = try await firestoreService.fetchSpecialists(salonId: salonId)
        } catch {
            self.errorMessage = "Uzmanlar alınamadı: \(error.localizedDescription)"
        }
        isLoading = false
    }

    func saveAppointment(userId: String,
                         userName: String,
                         specialistName: String,
                         specialistID: String,
                         selectedDate: Date,
                         selectedTime: String) async -> Appointment? {

        let newAppointment = Appointment(
            date: selectedDate,
            time: selectedTime,
            specialistId: specialistID,
            specialistName: specialistName,
            userName: userName,
            userId: userId,
            status: .upcoming
        )

        isLoading = true
        do {
            try await bookingService.saveAppointment(newAppointment)
            isLoading = false
            return newAppointment
        } catch {
            self.errorMessage = "Randevu kaydedilemedi: \(error.localizedDescription)"
            isLoading = false
            return nil
        }
    }
}
