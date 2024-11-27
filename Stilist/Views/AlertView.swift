//
//  AlertView.swift
//  Stilist
//
//  Created by Yasin Cetin on 16.11.2024.
//

import SwiftUI

struct AlertView: View {
    
    @Binding var isPresented: Bool
    var message: String?
    
    var body: some View {
        if isPresented {
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    VStack(alignment: .center, spacing: 10) {
                        Text("Error")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text(message ?? "Error")
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        Button(action: {
                            isPresented = false
                        }) {
                            Text("OK")
                                .foregroundColor(.white)
                                .bold()
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.red)
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                    .background(Color.black.opacity(0.8))
                    .cornerRadius(12)
                    Spacer()
                }
                .padding(.horizontal, 40)
                
                Spacer()
            }
            .transition(.opacity)
            .animation(.easeInOut, value: isPresented)
        }
    }
}

