//
//  ErrorAlertModifier.swift
//  Stilist
//
//  Created by Yasin Cetin on 9.02.2025.
//

import SwiftUI

struct ErrorAlertModifier: ViewModifier {

    @Binding var errorMessage: String?

    private var isPresented: Binding<Bool> {
        Binding(
            get: { errorMessage != nil },
            set: { if !$0 { errorMessage = nil } }
        )
    }

    func body(content: Content) -> some View {
        content
            .alert("Hata", isPresented: isPresented) {
                Button("Tamam", role: .cancel) { }
            } message: {
                Text(errorMessage ?? "")
            }
    }
}

extension View {
    func errorAlert(message: Binding<String?>) -> some View {
        modifier(ErrorAlertModifier(errorMessage: message))
    }
}
