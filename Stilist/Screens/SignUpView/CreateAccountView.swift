//
//  CreateAccountView.swift
//  Stilist
//
//  Created by Yasin Cetin on 15.11.2024.
//

import SwiftUI

struct CreateAccountView: View {
    
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    @StateObject var authViewModel = AuthViewModel()
    
    @State private var email = ""
    @State private var password = ""
    @State private var rememberMe = false
    @State private var showAlert = false
   
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Spacer()
                
                // Title
                Text("Create your Account")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                // Email & Password Fields
                VStack(spacing: 15) {
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .overlay(
                            HStack {
                                Spacer()
                                Image(systemName: "envelope")
                                    .padding()
                                
                            }
                            .padding(.leading, 10)
                            .foregroundColor(.gray)
                        )
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
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
                            Text("Remember me")
                                
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal, 30)
                
                Button(action: {
                    authViewModel.createUser(email: email, password: password) { error in
                        if let error = error {
                            showAlert = true
                        }else {
                            navigationViewModel.navigateTo("FillProfileView")
                        }
                    }
                    
                }) {
                    Text("Sign up")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(8)
                }
                .padding(.horizontal, 30)
                
                Spacer().frame(height: 20)
                
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
                    SocialLoginIcon(imageName: "facebook")
                    SocialLoginIcon(imageName: "google")
                    SocialLoginIcon(imageName: "applelogo")
                }
                
                Spacer()
                
                // Sign in link
                HStack {
                    Text("Already have an account?")
                        .foregroundColor(.gray)
                    
                    Button(action: {
                        // Sign in action
                    }) {
                        Text("Sign in")
                            .foregroundColor(.orange)
                            .fontWeight(.semibold)
                    }
                }
            }
            .padding()
            
            AlertView(isPresented: $showAlert, message: authViewModel.errorMessage)
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

