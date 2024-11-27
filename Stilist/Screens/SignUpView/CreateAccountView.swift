//
//  CreateAccountView.swift
//  Stilist
//
//  Created by Yasin Cetin on 15.11.2024.
//

import SwiftUI

struct CreateAccountView: View {
    
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State private var showAlert: Bool = false
    
    @State private var name = ""
    @State private var email = ""
    @State private var phoneNumber = ""
    @State private var password = ""
    
    @State private var errorMessage: String?
    
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Spacer()
                
                // Title
                Text("Fill Your Profile")
                    .font(.title)
                    .fontWeight(.bold)
                    
                
                // Profile Picture Placeholder
                ZStack {
                    Image(systemName: "Person.crop.circle.fill")
                        .resizable()
                        .foregroundStyle(Color.white)
                        .frame(width: 90, height: 90)
                        .overlay {
                            Image(systemName: "pencil.circle.fill")
                                .foregroundColor(.orange)
                                .background(Circle()
                                    .fill(Color.white)
                                    .frame(width: 24, height: 24))
                        }
                        .onTapGesture {
                            // profil fotoğrafı seçimi
                        }
                    
                    
                }
                
                // Form Fields
                VStack(spacing: 15) {
                    TextField("Full Name", text: $name)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                    
                    TextField("Phone Number", text: $phoneNumber)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                    TextField("Password", text: $password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                    /*
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
                    */
                    
                }
                
                .padding(.horizontal, 30)
                
                // Continue Button
                Button(action: {
                    authViewModel.createUser(name: name, email: email, phoneNumber: phoneNumber, password: password) { error in
                        if let error = error {
                            errorMessage = error.localizedDescription
                            showAlert = true
                            print(error.localizedDescription)
                            
                        }
                    }
                    authViewModel.signIn(email: email, password: password) { error in
                        if let error = error {
                            errorMessage = error.localizedDescription
                            showAlert = true
                            print(error.localizedDescription)
                        }
                    }
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
            
            AlertView(isPresented: $showAlert, message: errorMessage)
        }
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}

struct SocialLoginIcon: View {
    var imageName: String
    
    var body: some View {
        Button(action: {
            // Social login action
        }) {
            Image(systemName: imageName)
                .frame(width: 50, height: 50)
                .background(Color.white)
                .cornerRadius(25)
                .shadow(radius: 1)
                .foregroundColor(.black)
        }
    }
}

