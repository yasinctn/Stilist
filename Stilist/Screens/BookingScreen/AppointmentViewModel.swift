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
    @Published var selectedSpecialistId: String = "765464654654"
    @Published var specialists: [Specialist] = []
    @Published var appointments: [Appointment] = []
    
    private let bookingService: BookingServiceProtocol
    
    init(bookingService: BookingServiceProtocol = BookingService()) {
        self.bookingService = bookingService
        fetchSpecialists()
    }
    
    func fetchSpecialists() {
        // Test verileri örnek olarak eklendi
        
    }
    
    func saveAppointment(userId: String) {
        guard !selectedTime.isEmpty, !selectedSpecialistId.isEmpty else {
            return
        }
        
        let newAppointment = Appointment(
            date: selectedDate,
            time: selectedTime,
            specialistId: selectedSpecialistId,
            userId: userId,
            status: Status.upcoming
            
        )
        
        bookingService.saveAppointment(newAppointment) { error in
            if let error = error {
                print("Randevu kaydedilemedi: \(error.localizedDescription)")
            } else {
                print("Randevu başarıyla kaydedildi!")
            }
        }
    }
    
    
}
