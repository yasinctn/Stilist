//
//  BookingsViewModel.swift
//  Stilist
//
//  Created by Yasin Cetin on 20.12.2024.
//

import SwiftUI

class BookingsViewModel: ObservableObject {
    
    @Published var upcomingBookings: [Appointment] = []
    @Published var completedBookings: [Appointment] = []
    @Published var cancelledBookings: [Appointment] = []
    private let bookingService: BookingServiceProtocol
    
    init(bookingService: BookingServiceProtocol = BookingService()) {
        self.bookingService = bookingService
    }
    
    func fetchBookings(userId: String, status: Status) {
        bookingService.fetchAppointments(for: userId, status: status) { result in
            switch result {
            case .success(let appointments):
                switch status {
                case .cancelled:
                    DispatchQueue.main.async {
                        self .cancelledBookings = appointments
                    }
                case .upcoming:
                    DispatchQueue.main.async {
                        self.upcomingBookings = appointments
                    }
                case .completed:
                    DispatchQueue.main.async {
                        self.completedBookings = appointments
                    }
                }
                
            case .failure(let error):
                print("Randevular alınamadı: \(error.localizedDescription)")
            }
        }
    }
    
}

