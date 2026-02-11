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
        Group {
            if viewModel.isLoading {
                LoadingView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if viewModel.appointments.isEmpty {
                VStack(spacing: 12) {
                    Spacer()
                    Image(systemName: "calendar.badge.exclamationmark")
                        .font(.largeTitle)
                        .foregroundColor(.secondary)
                    Text("Henüz randevu yok")
                        .foregroundColor(.secondary)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            } else {
                List(viewModel.appointments) { appointment in
                    BookingCardView(appointment: appointment)
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchAppointments(userId: authViewModel.currentUser?.id ?? "")
            }
        }
        .errorAlert(message: $viewModel.errorMessage)
    }
}

#Preview {
    SpecialistHomeView()
}
