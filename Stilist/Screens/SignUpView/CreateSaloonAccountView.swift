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
    
    @State var saloonName = ""
    @State var userName = ""
    @State var email = ""
    @State var phoneNumber = ""
    @State var address = ""
    @State var password = ""
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    
                    TextField("İşletme Adı", text: $saloonName)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                    
                    TextField("Mail Adresi", text: $email)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .keyboardType(.emailAddress)
                    
                    TextField("Telefon Numarası", text: $phoneNumber)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .keyboardType(.phonePad)
                    
                    TextField("Adres", text: $address)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                    
                    TextField("Parola", text: $phoneNumber)
                        .textFieldStyle(.plain)
                        .lineLimit(5)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    Spacer()
                    Button(action: {
                        
                        locationManager.convertAddress(address: address)
                        
                        authViewModel.createUser(name: userName, surname: userName, email: email, phoneNumber: phoneNumber, password: password, role: .admin) { error in
                            if let error {
                                
                                print(error.localizedDescription)
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
                }
                
            }
            .padding(.horizontal)
            .padding(.bottom, 30)
        }
        .navigationTitle(
            Text("Kuaför Kaydı")
        )
    }
}

#Preview {
    CreateSaloonAccountView()
}
