//
//  StyledTextField.swift
//  Stilist
//
//  Created by Yasin Cetin on 2026.
//

import SwiftUI

struct StyledTextField: View {
    var placeholder: String
    var iconName: String?
    @Binding var text: String
    var isSecure: Bool = false
    var keyboardType: UIKeyboardType = .default

    var body: some View {
        Group {
            if isSecure {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
                    .keyboardType(keyboardType)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
        .overlay(
            HStack {
                Spacer()
                if let iconName = iconName {
                    Image(systemName: iconName)
                        .padding()
                        .foregroundColor(.gray)
                }
            }
        )
    }
}

#Preview {
    VStack(spacing: 15) {
        StyledTextField(
            placeholder: "Email",
            iconName: "envelope",
            text: .constant("")
        )
        StyledTextField(
            placeholder: "Parola",
            iconName: "lock",
            text: .constant(""),
            isSecure: true
        )
        StyledTextField(
            placeholder: "Ad",
            text: .constant("")
        )
    }
    .padding(.horizontal, 30)
}
