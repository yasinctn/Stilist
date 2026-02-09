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
    @Published var isLoading = false
    private let bookingService: BookingServiceProtocol
    
    init(bookingService: BookingServiceProtocol = BookingService()) {
        self.bookingService = bookingService
    }
    
    func fetchBookings(userId: String, status: Status) {
        isLoading = true
        bookingService.fetchAppointments(userId: userId, status: status) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let appointments):
                    switch status {
                    case .cancelled:
                        self.cancelledBookings = appointments
                    case .upcoming:
                        self.upcomingBookings = appointments
                    case .completed:
                        self.completedBookings = appointments
                    }
                case .failure(let error):
                    print("Randevular alınamadı: \(error.localizedDescription)")
                }
            }
        }
    }
    
}

