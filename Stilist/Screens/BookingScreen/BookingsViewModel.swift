//
//  BookingsViewModel.swift
//  Stilist
//
//  Created by Yasin Cetin on 20.12.2024.
//

import SwiftUI

@MainActor
class BookingsViewModel: ObservableObject {

    @Published var upcomingBookings: [Appointment] = []
    @Published var completedBookings: [Appointment] = []
    @Published var cancelledBookings: [Appointment] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    private let bookingService: BookingServiceProtocol

    init(bookingService: BookingServiceProtocol = BookingService()) {
        self.bookingService = bookingService
    }

    func fetchBookings(userId: String) async {
        isLoading = true
        do {
            let appointments = try await bookingService.fetchAppointments(userId: userId)
            self.upcomingBookings = appointments.filter { $0.status == .upcoming }
            self.completedBookings = appointments.filter { $0.status == .completed }
            self.cancelledBookings = appointments.filter { $0.status == .cancelled }
        } catch {
            self.errorMessage = "Randevular alınamadı: \(error.localizedDescription)"
        }
        isLoading = false
    }
}
