//
//  SpecialistHomeView.swift
//  Stilist
//
//  Created by Yasin Cetin on 11.01.2025.
//

import SwiftUI

struct SpecialistHomeView: View {
    
    @EnvironmentObject var viewModel: SpecialistHomeViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        List(viewModel.appointments) { appointment in
            
            BookingCardView(appointment: appointment)
            
        }
        .onAppear {
            viewModel.fetchAppointments()
        }
    }
}

#Preview {
    SpecialistHomeView()
}
