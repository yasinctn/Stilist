//
//  EntryView.swift
//  Stilist
//
//  Created by Yasin Cetin on 15.11.2024.
//

import SwiftUI

struct EntryView: View {
    
    @EnvironmentObject private var authViewModel: AuthViewModel
    @EnvironmentObject private var navigationViewModel: NavigationViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            // Illustration
            Image(systemName: "person.crop.circle.badge.plus")
                .resizable()
                .frame(width: 100, height: 100)
                .padding()
            
            // Title
            Text("Let's you in")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.black)
            
            Spacer()
                .frame(height: 20)
            
            // Social Buttons
            VStack(spacing: 15) {
                SocialLoginButton(imageName: "facebook", text: "Continue with Facebook", color: Color.blue)
                SocialLoginButton(imageName: "google", text: "Continue with Google", color: Color.red)
                SocialLoginButton(imageName: "applelogo", text: "Continue with Apple", color: Color.black)
            }
            
            Spacer()
                .frame(height: 20)
            
            // Divider
            HStack {
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
                
                Text("or")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 30)
            
            // Sign in with password button
            Button(action: {
                navigationViewModel.navigateTo("LoginView")
            }) {
                Text("Sign in with password")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
                    .cornerRadius(8)
            }
            .padding(.horizontal, 30)
            
            Spacer()
            
            // Sign up link
            HStack {
                Text("Don't have an account?")
                    .foregroundColor(.gray)
                
                Button(action: {
                    navigationViewModel.navigateTo("CreateAccount")
                }) {
                    Text("Sign up")
                        .foregroundColor(.orange)
                        .fontWeight(.semibold)
                }
            }
        }
        .padding()
    }
}

#Preview {
    EntryView()
}
