//
//  AppointmentView.swift
//  Stilist
//
//  Created by Yasin Cetin on 16.11.2024.
//

import SwiftUI

struct AppointmentView: View {
    
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var viewModel: AppointmentViewModel
    
    @State private var selectedDate: Date = Date.now
    
    var body: some View {
        ScrollView {
            Text("Randevu Oluştur")
                .font(.title)
                .padding()
            VStack(alignment: .leading) {
                
                
                Text("Uzman Seçin")
                    .font(.headline)
                    .padding(.top)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(viewModel.specialists) { specialist in
                            VStack {
                                Image("")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                                
                                Text("specialist.name")
                                    .font(.subheadline)
                                
                                Text("specialist.role")
                                    .font(.caption)
                            }
                            .padding()
                            
                            //.background(viewModel.selectedSpecialistId == specialist.id ? Color.orange.opacity(0.3) : Color.clear)
                            .cornerRadius(10)
                            .onTapGesture {
                                //viewModel.selectedSpecialistId = specialist.id
                            }
                        }
                    }
                    .padding()
                }
                .padding()
                
                DatePicker("Tarih seçin", selection: $viewModel.selectedDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                
                Text("Saat Seçin")
                    .font(.headline)
                    .padding(.top)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(["09:00", "10:00", "11:00", "12:00", "13:00", "14:00"], id: \.self) { time in
                            Text(time)
                                .padding()
                                .background(viewModel.selectedTime == time ? Color.orange : Color.gray.opacity(0.2))
                                .cornerRadius(10)
                                .onTapGesture {
                                    viewModel.selectedTime = time
                                }
                        }
                    }
                    .padding()
                }
                
                Button(action: {
                    guard let userId = AuthViewModel().currentUser?.id else { return }
                    
                    viewModel.saveAppointment(userId: userId)
                }) {
                    Text("Oluştur")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.primary)
                        .cornerRadius(10)
                }
                .padding()
            }
            .padding()
        }
    }
}


#Preview {
    AppointmentView()
        .environmentObject(AppointmentViewModel())
        .environmentObject(AuthViewModel())
}
