//
//  CreateSpecialistAccountView.swift
//  Stilist
//
//  Created by Yasin Cetin on 7.12.2024.
//

import SwiftUI

struct CreateSpecialistAccountView: View {
    
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State private var showAlert: Bool = false
    
    @State private var name = ""
    @State private var surname = ""
    @State private var email = ""
    @State private var phoneNumber = ""
    @State private var password = ""
    @State private var salonCode = ""
    
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
                    
                    TextField("Soyad", text: $name)
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
                    
                    TextField("Salon Kodu", text: $salonCode)
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
                    authViewModel.createUser(name: name, surname: surname, email: email, phoneNumber: phoneNumber, password: password, role: .specialist) { error in
                        if let error = error {
                            errorMessage = error.localizedDescription
                            showAlert = true
                            print(error.localizedDescription)
                            
                        
                        }else {
                            
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
                
                
            }
            .padding()
            
            AlertView(isPresented: $showAlert, message: errorMessage)
        }
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

#Preview {
    CreateSpecialistAccountView()
}
