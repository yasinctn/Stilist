//
//  SocialLoginButton.swift
//  Stilist
//
//  Created by Yasin Cetin on 15.11.2024.
//

import SwiftUI

struct SocialLoginButton: View {
    var imageName: String
    var text: String
    var color: Color
    
    var body: some View {
        Button(action: {
            // Social sign-in action
        }) {
            HStack {
                /*
                Image(systemName: imageName)
                    .frame(width: 20, height: 20)
                */
                Text(text)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 1)
        }
        .padding(.horizontal, 30)
    }
}

