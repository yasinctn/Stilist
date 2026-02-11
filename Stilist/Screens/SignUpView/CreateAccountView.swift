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
    @State private var surname = ""
    @State private var email = ""
    @State private var phoneNumber = ""
    @State private var password = ""
    
    @State private var errorMessage: String?

    private var isFormValid: Bool {
        !name.isEmpty && !surname.isEmpty && !email.isEmpty && email.contains("@") && !phoneNumber.isEmpty && !password.isEmpty && password.count >= 6
    }

    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Spacer()
                
                // Title
                Text("Profilini oluştur")
                    .font(.title)
                    .fontWeight(.bold)
                
                
                // Profile Picture Placeholder
                ZStack {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .foregroundStyle(Color.white)
                        .frame(width: 100, height: 90)
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
                    StyledTextField(placeholder: "Ad", text: $name)

                    StyledTextField(placeholder: "Soyad", text: $surname)

                    StyledTextField(
                        placeholder: "Email",
                        text: $email,
                        keyboardType: .emailAddress
                    )

                    StyledTextField(
                        placeholder: "Telefon",
                        text: $phoneNumber,
                        keyboardType: .numberPad
                    )

                    StyledTextField(
                        placeholder: "Parola",
                        text: $password,
                        isSecure: true
                    )
                }
                .padding(.horizontal, 30)
                    // Continue Button
                    Button(action: {
                        Task {
                            await authViewModel.createUser(name: name, surname: surname, email: email, phoneNumber: phoneNumber, password: password, role: .customer)
                            if let error = authViewModel.errorMessage {
                                errorMessage = error
                                showAlert = true
                            }
                        }

                    }) {
                        Text("Kaydol")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal, 30)
                    .disabled(!isFormValid || authViewModel.isLoading)
                    .opacity(isFormValid && !authViewModel.isLoading ? 1.0 : 0.6)

                    if authViewModel.isLoading {
                        ProgressView()
                            .padding(.top, 5)
                    }
                    Spacer()
                    
                    HStack {
                        Text("Uzmanlar için")
                            .foregroundColor(.gray)
                        
                        Button(action: {
                            navigationViewModel.navigateTo("CreateSpecialistAccount")
                        }) {
                            Text("Hesap Oluştur")
                                .foregroundColor(.orange)
                                .fontWeight(.semibold)
                        }
                    }
                    
                    HStack {
                        Text("İşletme için")
                            .foregroundColor(.gray)
                        
                        Button(action: {
                            navigationViewModel.navigateTo("CreateSaloonAccount")
                        }) {
                            Text("Hesap Oluştur")
                                .foregroundColor(.orange)
                                .fontWeight(.semibold)
                        }
                    }
                }
                .padding()
                
                AlertView(isPresented: $showAlert, message: errorMessage)
            }
        }
    }


#Preview {
    CreateAccountView()
}


