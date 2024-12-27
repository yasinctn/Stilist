//
//  AppointmentView.swift
//  Stilist
//
//  Created by Yasin Cetin on 16.11.2024.
//

import SwiftUI

struct AppointmentView: View {
    
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    @EnvironmentObject var viewModel: AppointmentViewModel
    
    @State private var selectedDate: Date = Date.now
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Book Appointment")
                    .font(.title)
                    .padding()
                
                DatePicker("Select Date", selection: $viewModel.selectedDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                
                Text("Select Hours")
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
                
                Text("Select Specialist")
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
                
                Button(action: {
                    let userId = AuthViewModel().currentUser?.uid ?? ""
                    
                    viewModel.saveAppointment(userId: userId)
                }) {
                    Text("Continue")
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
    AppointmentView().environmentObject(AppointmentViewModel())
}
