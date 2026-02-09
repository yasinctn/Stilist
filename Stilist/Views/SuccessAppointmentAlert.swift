//
//  SuccessAppointmentAlert.swift
//  Stilist
//
//  Created by Yasin Cetin on 13.01.2025.
//

import SwiftUI

struct SuccessAppointmentAlert: View {
    @Binding var isPresented: Bool
    var appointment: Appointment?
    
    var body: some View {
        if isPresented {
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    VStack(alignment: .center, spacing: 10) {
                        
                        Text("Randevu Oluşturuldu")
                            .font(.title)
                            .foregroundColor(.orange)
                            .bold()
                        
                        Image(systemName: "checkmark.seal.text.page")
                            .resizable()
                            .frame(width: 90, height: 150)
                            .padding()
                            .foregroundStyle(Color.orange)
                            .cornerRadius(8)
                        
                        Text("Randevunuz başarıyla oluşturuldu")
                            .padding()

                        if let appointment = appointment {
                            BookingCardView(appointment: appointment)
                        }
                        
                        
                        Button(action: {
                            isPresented = false
                        }) {
                            Text("OK")
                                .foregroundColor(.white)
                                .bold()
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.orange)
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                    .background(Color.white)
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

