//
//  LoginView.swift
//  Stilist
//
//  Created by Yasin Cetin on 15.11.2024.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State private var email = ""
    @State private var password = ""
    @State private var rememberMe = false
    @State private var showAlert = false
    
    @State private var errorMessage: String?

    private var isFormValid: Bool {
        !email.isEmpty && email.contains("@") && !password.isEmpty && password.count >= 6
    }

    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Spacer()
                
                // Title
                Text("Hesabınıza giriş yapın")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                // Email & Password Fields
                VStack(spacing: 15) {
                    StyledTextField(
                        placeholder: "Email",
                        iconName: "envelope",
                        text: $email,
                        keyboardType: .emailAddress
                    )

                    StyledTextField(
                        placeholder: "Parola",
                        iconName: "lock",
                        text: $password,
                        isSecure: true
                    )
                }
                .padding(.horizontal, 30)
                
                // Remember Me & Sign Up Button
                HStack {
                    Button(action: {
                        rememberMe.toggle()
                    }) {
                        HStack {
                            Image(systemName: rememberMe ? "checkmark.square" : "square")
                                .foregroundColor(.orange)
                            Text("Beni hatırla")
                                .foregroundStyle(Color.orange)
                                
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal, 30)
                
                Button(action: {
                    //giriş işlemi
                    Task {
                        await authViewModel.signIn(email: email, password: password)
                        if let error = authViewModel.errorMessage {
                            errorMessage = error
                            showAlert = true
                        }
                    }

                }) {
                    Text("Giriş yap")
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
                    .frame(height: 20)
                
                // Divider
                HStack {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                    
                    Text("or continue with")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 30)
                
                // Social Buttons
                HStack(spacing: 20) {
                    SocialLoginIcon(imageName: "applelogo")
                    SocialLoginIcon(imageName: "applelogo")
                    SocialLoginIcon(imageName: "applelogo")
                }
                
                Spacer()
                
                // Sign in link
                HStack {
                    Text("Already have an account?")
                        .foregroundColor(.gray)
                    
                    Button(action: {
                        
                    }) {
                        Text("Barber Account")
                            .foregroundColor(.orange)
                            .fontWeight(.semibold)
                    }
                }
                .padding()
            }
            
            AlertView(isPresented: $showAlert, message: errorMessage)
            
        }
    }
}

