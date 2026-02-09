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
    
    @Published var specialists: [Specialist] = []
    @Published var appointments: [Appointment] = []
    @Published var isLoading = false
    
    private let bookingService: BookingServiceProtocol
    private let firestoreService: FirestoreService
    
    init(bookingService: BookingServiceProtocol = BookingService(), firestoreService: FirestoreService = FirestoreService()) {
        self.bookingService = bookingService
        self.firestoreService = firestoreService
        
    }
    
    func fetchSpecialists(salonId: String) async {
        DispatchQueue.main.async { self.isLoading = true }
        firestoreService.fetchSpecialists(salonId: salonId) { error, specialist in
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    print(error.localizedDescription)
                } else if let specialist {
                    self.specialists = specialist
                }
            }
        }
    }
    
    func saveAppointment(userId: String,
                         userName: String,
                         specialistName: String,
                         specialistID: String,
                         selectedDate: Date,
                         selectedTime: String,
                         completion: @escaping (Appointment) -> Void) {
            
            let newAppointment = Appointment(
                date: selectedDate,
                time: selectedTime,
                specialistId: specialistID,
                specialistName: specialistName,
                userName: userName,
                userId: userId,
                status: Status.upcoming
                
            )
            
            bookingService.saveAppointment(newAppointment) { error in
                if let error = error {
                    print("Randevu kaydedilemedi: \(error.localizedDescription)")
                } else {
                    completion(newAppointment)
                    print("Randevu başarıyla kaydedildi!")
                }
            }
        
        
        
    }
    
    
}
