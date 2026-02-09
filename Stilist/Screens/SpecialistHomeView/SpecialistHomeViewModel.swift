//
//  SpecialistHomeViewModel.swift
//  Stilist
//
//  Created by Yasin Cetin on 11.01.2025.
//

import Foundation

final class SpecialistHomeViewModel: ObservableObject {
    
    private var bookingService: BookingServiceProtocol?
    private var authViewModel: AuthViewModel?
    
    @Published var appointments: [Appointment] = []
    @Published var isLoading = false
    
    
    init(bookingService: BookingServiceProtocol = BookingService(), authViewModel: AuthViewModel = AuthViewModel()) {
        self.bookingService = bookingService
        self.authViewModel = authViewModel
        fetchAppointments()
    }
    
    func fetchAppointments() {
        guard let userId = authViewModel?.currentUser?.id else { return }
        isLoading = true
        bookingService?.fetchAppointments(userId: userId, status: .upcoming, completion: { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let appointments):
                    self?.appointments = appointments
                case .failure(let error):
                    print(error)
                }
            }
        })
    }
    
}

