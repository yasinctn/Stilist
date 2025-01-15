//
//  BookingCardView.swift
//  Stilist
//
//  Created by Yasin Cetin on 13.01.2025.
//

import SwiftUI

struct BookingCardView: View {
    var appointment: Appointment
    var showActions: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(appointment.date.formatted())
                .font(.subheadline)
                .foregroundColor(.primary)
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(appointment.specialistName)
                        .font(.headline)
                    Text(appointment.userName)
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
