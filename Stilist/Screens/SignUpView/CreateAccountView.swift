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
                    TextField("Ad", text: $name)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                    TextField("Soyad", text: $surname)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .keyboardType(.emailAddress)
                    
                    
                    TextField("Telefon", text: $phoneNumber)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .keyboardType(.numberPad)
                    
                    TextField("Parola", text: $password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .keyboardType(.numberPad)
                }
                .padding(.horizontal, 30)
                    // Continue Button
                    Button(action: {
                        authViewModel.createUser(name: name, surname: surname, email: email, phoneNumber: phoneNumber, password: password, role: .customer) { error in
                            if let error = error {
                                errorMessage = error.localizedDescription
                                showAlert = true
                                print(error.localizedDescription)
                                
                                
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


