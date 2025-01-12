//
//  SpecialistHomeViewModel.swift
//  Stilist
//
//  Created by Yasin Cetin on 11.01.2025.
//

import Foundation
import SwiftUICore

final class SpecialistHomeViewModel: ObservableObject {
    
    private var bookingService: BookingServiceProtocol?
    private var authViewModel: AuthViewModel?
    
    @Published var appointments: [Appointment] = []
    
    
    init(bookingService: BookingServiceProtocol = BookingService(), authViewModel: AuthViewModel = AuthViewModel()) {
        self.bookingService = bookingService
        self.authViewModel = authViewModel
        fetchAppointments()
    }
    
    func fetchAppointments() {
        guard let userId = authViewModel?.currentUser?.id else { return }
        bookingService?.fetchAppointments(userId: userId, status: .upcoming, completion: { result in
            switch result {
            case .success(let appointments):
                self.appointments = appointments
            case .failure(let error):
                print(error)
            }
        })
    }
    
}

