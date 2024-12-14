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
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .keyboardType(.emailAddress)
                        .overlay(
                            HStack {
                                Spacer()
                                Image(systemName: "envelope")
                                    .padding()
                            }
                            .padding(.leading, 10)
                            .foregroundColor(.gray)
                        )
                    
                    SecureField("Parola", text: $password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .keyboardType(.numberPad)
                        .overlay(
                            HStack {
                                Spacer()
                                Image(systemName: "lock")
                                    .padding()
                            }
                            .padding(.leading, 10)
                            .foregroundColor(.gray)
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
                    authViewModel.signIn(email: email, password: password) { error in
                        
                        if let error = error {
                            
                            errorMessage = error.localizedDescription
                            showAlert = true
                            print(showAlert)
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

