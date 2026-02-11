//
//  SpecialistHomeViewModel.swift
//  Stilist
//
//  Created by Yasin Cetin on 11.01.2025.
//

import Foundation

@MainActor
final class SpecialistHomeViewModel: ObservableObject {

    private var bookingService: BookingServiceProtocol?

    @Published var appointments: [Appointment] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    init(bookingService: BookingServiceProtocol = BookingService()) {
        self.bookingService = bookingService
    }

    func fetchAppointments(userId: String) async {
        isLoading = true
        do {
            self.appointments = try await bookingService?.fetchAppointments(userId: userId) ?? []
        } catch {
            self.errorMessage = "Randevular alınamadı: \(error.localizedDescription)"
        }
        isLoading = false
    }
}
