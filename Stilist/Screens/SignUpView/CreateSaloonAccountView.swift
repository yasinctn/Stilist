//
//  CreateSaloonAccountView.swift
//  Stilist
//
//  Created by Yasin Cetin on 27.11.2024.
//

import SwiftUI
import MapKit
import CoreLocation

struct CreateSaloonAccountView: View {
    
    @EnvironmentObject private var locationManager: LocationManager
    @EnvironmentObject private var navigationViewModel: NavigationViewModel
    @EnvironmentObject private var authViewModel: AuthViewModel
    
    @State private var showAlert: Bool = false
    @State private var errorMessage: String?

    @State var saloonName = ""
    @State var userName = ""
    @State var email = ""
    @State var phoneNumber = ""
    @State var address = ""
    @State var password = ""

    private var isFormValid: Bool {
        !saloonName.isEmpty && !email.isEmpty && email.contains("@") && !phoneNumber.isEmpty && !address.isEmpty && !password.isEmpty && password.count >= 6
    }

    var body: some View {
        ZStack {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    StyledTextField(placeholder: "İşletme Adı", text: $saloonName)

                    StyledTextField(
                        placeholder: "Mail Adresi",
                        text: $email,
                        keyboardType: .emailAddress
                    )

                    StyledTextField(
                        placeholder: "Telefon Numarası",
                        text: $phoneNumber,
                        keyboardType: .phonePad
                    )

                    StyledTextField(placeholder: "Adres", text: $address)

                    StyledTextField(
                        placeholder: "Parola",
                        text: $password,
                        isSecure: true
                    )
                    Spacer()
                    Button(action: {

                        locationManager.convertAddress(address: address)

                        Task {
                            await authViewModel.createUser(name: saloonName, surname: "", email: email, phoneNumber: phoneNumber, password: password, role: .admin)
                            if let error = authViewModel.errorMessage {
                                errorMessage = error
                                showAlert = true
                            }
                        }

                    } ) {
                        Text("Kaydol")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .disabled(!isFormValid || authViewModel.isLoading)
                    .opacity(isFormValid && !authViewModel.isLoading ? 1.0 : 0.6)

                    if authViewModel.isLoading {
                        ProgressView()
                            .padding(.top, 5)
                    }
                }

            }
            .padding(.horizontal)
            .padding(.bottom, 30)
        }
        .navigationTitle(
            Text("Kuaför Kaydı")
        )

            AlertView(isPresented: $showAlert, message: errorMessage)
        }
    }
}

#Preview {
    CreateSaloonAccountView()
}
