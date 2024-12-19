//
//  MyBookingView.swift
//  Stilist
//
//  Created by Yasin Cetin on 30.11.2024.
//

import SwiftUI

struct MyBookingView: View {
    
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    @EnvironmentObject var viewModel: AppointmentViewModel
    
    @State private var selectedTab: String = "Upcoming"
    
    var body: some View {
        VStack {
            // Tab Selector
            HStack {
                BookingTabButton(title: "Upcoming", selectedTab: $selectedTab)
                BookingTabButton(title: "Completed", selectedTab: $selectedTab)
                BookingTabButton(title: "Cancelled", selectedTab: $selectedTab)
            }
            .padding(.horizontal)
            
            // Booking List
            ScrollView {
                if selectedTab == "Upcoming" {
                    ForEach(upcomingBookings) { booking in
                        BookingCard(booking: booking, showActions: true)
                    }
                } else if selectedTab == "Completed" {
                    ForEach(completedBookings) { booking in
                        BookingCard(booking: booking, showActions: false)
                    }
                } else {
                    ForEach(cancelledBookings) { booking in
                        BookingCard(booking: booking, showActions: false)
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
    
    var body: some View {
        Button(action: {
            selectedTab = title
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
    var booking: Booking
    var showActions: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(booking.date)
                .font(.subheadline)
                .foregroundColor(.primary)
            HStack {
                Image(booking.imageName)
                    .resizable()
                    .frame(width: 60, height: 60)
                    .cornerRadius(8)
                VStack(alignment: .leading, spacing: 4) {
                    Text(booking.barberName)
                        .font(.headline)
                    Text(booking.services)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
                Spacer()
                Text(booking.status)
                    .font(.footnote)
                    .foregroundColor(booking.statusColor)
                    .padding(6)
                    //.background(booking.statusColor.opacity(0.2))
                    .cornerRadius(10)
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
