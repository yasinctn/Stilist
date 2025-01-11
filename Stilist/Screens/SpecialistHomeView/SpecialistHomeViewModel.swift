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
    @Published var appointments: [Appointment] = []
    
    
    init(bookingService: BookingServiceProtocol = BookingService()) {
        self.bookingService = bookingService
    }
    
    func fetchAppointments() {
        
    }
    
}

