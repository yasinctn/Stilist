//
//  MyBookingView.swift
//  Stilist
//
//  Created by Yasin Cetin on 30.11.2024.
//

import SwiftUI

struct MyBookingView: View {
    
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    @EnvironmentObject var viewModel: BookingsViewModel
    
    @State private var selectedTab: String = "Yaklaşan"
    
    var body: some View {
        VStack {
            // Tab Selector
            HStack {
                BookingTabButton(title: "Yaklaşan", selectedTab: $selectedTab, action: {
                    viewModel.fetchBookings(userId: AuthViewModel().currentUser?.uid ?? "", status: .upcoming)
                })
                BookingTabButton(title: "Tamamlanan", selectedTab: $selectedTab, action: {
                    viewModel.fetchBookings(userId: AuthViewModel().currentUser?.uid ?? "", status: .completed)
                })
                BookingTabButton(title: "İptal", selectedTab: $selectedTab, action: {
                    viewModel.fetchBookings(userId: AuthViewModel().currentUser?.uid ?? "", status: .cancelled)
                })
            }
            .padding(.horizontal)
            
            // Booking List
            ScrollView {
                
                if selectedTab == "Yaklaşan" {
                    
                    ForEach(viewModel.upcomingBookings) { booking in
                        BookingCard(appointment: booking, showActions: true)
                    }
                } else if selectedTab == "Completed" {
                    ForEach(viewModel.completedBookings) { booking in
                        BookingCard(appointment: booking, showActions: false)
                    }
                } else {
                    ForEach(viewModel.cancelledBookings) { booking in
                        BookingCard(appointment: booking, showActions: false)
                    }
                }
            }
            .padding(.horizontal)
        }
        .background(Color(UIColor.systemBackground))
        .ignoresSafeArea(edges: .bottom)
        
    }
}

// Custom Tab Button
struct BookingTabButton: View {
    var title: String
    @Binding var selectedTab: String
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            selectedTab = title
            action()
        }) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(selectedTab == title ? .white : .orange)
                .padding()
                .background(selectedTab == title ? Color.orange : Color.clear)
                .cornerRadius(15)
        }
    }
}

// Booking Card
struct BookingCard: View {
    var appointment: Appointment
    var showActions: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(appointment.date.formatted())
                .font(.subheadline)
                .foregroundColor(.primary)
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(appointment.specialistId)
                        .font(.headline)
                    Text(appointment.userId)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
                Spacer()
                
                switch appointment.status {
                case .cancelled:
                    Text(appointment.status.rawValue)
                        .font(.footnote)
                        .foregroundColor(.red)
                        .padding(6)
                        //.background(booking.statusColor.opacity(0.2))
                        .cornerRadius(10)
                case .completed:
                    Text(appointment.status.rawValue)
                        .font(.footnote)
                        .foregroundColor(.green)
                        .padding(6)
                        //.background(booking.statusColor.opacity(0.2))
                        .cornerRadius(10)
                    Color.green
                case .upcoming:
                    Text(appointment.status.rawValue)
                        .font(.footnote)
                        .foregroundColor(.orange)
                        .padding(6)
                        //.background(booking.statusColor.opacity(0.2))
                        .cornerRadius(10)
                }
                    
            }
            if showActions {
                HStack {
                    Spacer()
                    Button("Cancel Booking") {
                        // Action for Cancel
                    }
                    .foregroundColor(.red)
                    
                    
                }
                .padding(.top, 8)
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
        
    }
        
}

//MARK: - DENEME
// Booking Model
struct Booking: Identifiable {
    var id = UUID()
    var date: String
    var barberName: String
    var services: String
    var status: String
    var statusColor: Color
    var imageName: String
}

// Sample Data
let upcomingBookings = [
    Booking(date: "Dec 23, 2024 - 10:00 AM", barberName: "Barbarella Inova", services: "Quiff Haircut, Thin Shaving", status: "Upcoming", statusColor: .orange, imageName: "barber1"),
    Booking(date: "Dec 08, 2024 - 15:00 PM", barberName: "Bombastic Barbers", services: "Undercut Haircut, Regular Shaving", status: "Upcoming", statusColor: .orange, imageName: "barber2")
]

let completedBookings = [
    Booking(date: "Nov 20, 2024 - 15:00 PM", barberName: "Modern Men Barber", services: "Undercut Haircut, Regular Shaving", status: "Completed", statusColor: .green, imageName: "barber3"),
    Booking(date: "Oct 18, 2024 - 11:00 AM", barberName: "Wicked Barber", services: "Quiff Haircut, Thin Shaving", status: "Completed", statusColor: .green, imageName: "barber4")
]

let cancelledBookings = [
    Booking(date: "Nov 20, 2024 - 13:00 PM", barberName: "Quinautura Salon", services: "Undercut Haircut, Regular Shaving", status: "Cancelled", statusColor: .red, imageName: "barber5"),
    Booking(date: "Oct 19, 2024 - 16:00 PM", barberName: "Luxuriate Barber", services: "Regular Shaving, Aloe Vera Wash", status: "Cancelled", statusColor: .red, imageName: "barber6")
]

#Preview {
    MyBookingView()
}
