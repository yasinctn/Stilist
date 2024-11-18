//
//  FillProfileView.swift
//  Stilist
//
//  Created by Yasin Cetin on 15.11.2024.
//

import SwiftUI

struct FillProfileView: View {
    
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State private var name = ""
    @State private var email = ""
    @State private var phoneNumber = ""
    @State private var dateOfBirth = Date()
    @State private var gender = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            // Title
            Text("Fill Your Profile")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            // Profile Picture Placeholder
            ZStack {
                Circle()
                    .fill(Color(.systemGray6))
                    .frame(width: 100, height: 100)
                
                Button(action: {
                    // Add profile picture action
                }) {
                    Image(systemName: "pencil.circle.fill")
                        .foregroundColor(.orange)
                        .background(Circle().fill(Color.white).frame(width: 24, height: 24))
                }
                .offset(x: 35, y: 35)
            }
            
            // Form Fields
            VStack(spacing: 15) {
                TextField("Full Name", text: $name)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                
                
                HStack {
                    TextField("Date of Birth", text: Binding(
                        get: { dateFormatter.string(from: dateOfBirth) },
                        set: { dateOfBirth = dateFormatter.date(from: $0) ?? Date() }
                    ))
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        HStack {
                            Spacer()
                            Image(systemName: "calendar")
                        }
                        .padding(.trailing, 10)
                        .foregroundColor(.gray)
                    )
                }
                
                TextField("Email", text: $email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                TextField("Phone Number", text: $phoneNumber)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                TextField("Gender", text: $gender)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            }
            .padding(.horizontal, 30)
            
            // Continue Button
            Button(action: {
                // Continue action
            }) {
                Text("Continue")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
                    .cornerRadius(8)
            }
            .padding(.horizontal, 30)
            
            Spacer()
        }
        .padding()
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}

#Preview {
    FillProfileView()
}
