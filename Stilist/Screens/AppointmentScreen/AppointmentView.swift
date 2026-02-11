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
    
    @State var selectedDate: Date = Date()
    @State var selectedTime: String = ""
    @State var selectedSpecialistId: String = ""
    @State var selectedSpecialistName: String?
    @State var selectedSalonID: String?
    
    @State var createdAppointment: Appointment?
    @State var showSuccessAlert: Bool = false
    
    var body: some View {
        ZStack {
            ScrollView {
                Text("Randevu Oluştur")
                    .font(.title)
                    .padding()
                VStack(alignment: .leading) {
                    
                    
                    Text("Uzman Seçin")
                        .font(.headline)
                        .padding(.top)

                    if viewModel.isLoading {
                        LoadingView()
                            .padding()
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(viewModel.specialists) { specialist in
                                VStack {
                                    SpecialistCellView(specialist: specialist)
                                        .onTapGesture {
                                            selectedSpecialistId = specialist.id
                                            selectedSpecialistName = specialist.name + specialist.surname
                                        }
                                }
                                .padding()
                                
                                .background(selectedSpecialistId == specialist.id ? Color.orange.opacity(0.3) : Color.clear)
                                .cornerRadius(10)
                                
                            }
                        }
                        .padding()
                    }
                    .padding()
                    
                    DatePicker("Tarih seçin", selection: $selectedDate, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                    
                    Text("Saat Seçin")
                        .font(.headline)
                        .padding(.top)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(["09:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00", "19:00", "20:00"], id: \.self) { time in
                                Text(time)
                                    .padding()
                                    .background(selectedTime == time ? Color.orange : Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        selectedTime = time
                                    }
                            }
                        }
                        .padding()
                    }
                    
                    Button(action: {
                        if let userId = authViewModel.currentUser?.id,
                           let userName = authViewModel.currentUser?.name,
                           let specialistName = selectedSpecialistName {
                            Task {
                                if let appointment = await viewModel.saveAppointment(userId: userId, userName: userName, specialistName: specialistName, specialistID: selectedSpecialistId, selectedDate: selectedDate, selectedTime: selectedTime) {
                                    self.createdAppointment = appointment
                                    self.showSuccessAlert = true
                                }
                            }
                        }
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
            
            SuccessAppointmentAlert(isPresented: $showSuccessAlert, appointment: createdAppointment)
        }
            .onAppear {
                if let selectedSalonID {
                    Task {
                        await viewModel.fetchSpecialists(salonId: selectedSalonID)
                    }
                }
            }
            .errorAlert(message: $viewModel.errorMessage)
        
    }
}


#Preview {
    AppointmentView()
        .environmentObject(AppointmentViewModel())
        .environmentObject(AuthViewModel())
}
