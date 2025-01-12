//
//  SalonDetailView.swift
//  Stilist
//
//  Created by Yasin Cetin on 26.11.2024.
//

import SwiftUI
import MapKit

struct SalonDetailView: View {
    
    @EnvironmentObject var viewModel: SalonDetailViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var chatViewModel: ChatViewModel
    @EnvironmentObject var messageViewModel: MessageViewModel
    @EnvironmentObject var appointmentViewModel: AppointmentViewModel
    
    @State var selectedSalonId: String?
    @State private var selectedTab: String = "Hakkımızda"
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                HStack {
                    Text(viewModel.salonDetail?.name ?? "")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    Text("Açık")
                        .foregroundColor(.green)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(10)
                }
                Text(viewModel.salonDetail?.address ?? "")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                // Değerlendirme ve İkonlar
                VStack(alignment: .leading) {
                    HStack(spacing: 2) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("4.8")
                    }
                    Text(String(viewModel.reviews.count))
                        .foregroundColor(.gray)
                    Spacer()
                    
                    HStack {
                        
                        NavigationLink {
                            MessageView(receiverID: viewModel.salonDetail?.id,
                                        senderID: authViewModel.currentUser?.id,
                                        barberName: viewModel.salonDetail?.name
                             )
                            .environmentObject(chatViewModel)
                            .environmentObject(authViewModel)
                            .environmentObject(messageViewModel)
                        } label: {
                            Text("Mesaj")
                                .padding(7)
                                .frame(maxWidth: .infinity)
                                .background(Color.orange)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        
                        NavigationLink {
                            AppointmentView(selectedSalonID: viewModel.salonDetail?.id)
                                .environmentObject(appointmentViewModel)
                                .environmentObject(authViewModel)
                        } label: {
                            Text("Randevu al")
                                .padding(7)
                                .frame(maxWidth: .infinity)
                                .background(Color.orange)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }

                        
                    }
                    .font(.system(size: 20))
                }
                .padding(.vertical)
                Divider()
                
                // Uzmanlarımız (Our Specialist) Bölümü
                VStack(alignment: .leading) {
                    Text("Uzmanlarımız")
                        .font(.headline)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            if viewModel.specialists.isEmpty {
                                ProgressView("Loading...")
                                    .progressViewStyle(CircularProgressViewStyle())
                                    .padding()
                            }else {
                                ForEach(viewModel.specialists) { specialist in
                                    VStack {
                                        Circle()
                                            .frame(width: 60, height: 60)
                                            .foregroundColor(.gray)
                                        Text("\(specialist.name) \(specialist.surname)")
                                            .font(.subheadline)
                                    }
                                }
                            }
                        }
                    }
                }.padding(.vertical)
                
                Divider()
                // Kısa Bilgi Kartları (About Us, Services, Package vs.)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(["Hakkımızda", "Hizmetler", "Yorumlar"], id: \.self) { tab in
                            Text(tab)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(selectedTab == tab ? Color.orange : Color.orange.opacity(0.1))
                                .foregroundColor(selectedTab == tab ? .white : .black)
                                .cornerRadius(20)
                                .onTapGesture {
                                    selectedTab = tab
                                }
                        }
                    }
                }
                
                Divider()
                
                
                if selectedTab == "Hakkımızda"{
                    AboutUsView(salonDetail: viewModel.salonDetail)
                }
                else if selectedTab == "Hizmetler" {
                    ServicesView(services: viewModel.services)
                }
                else if selectedTab == "Yorumlar" {
                    ReviewsView(reviews: viewModel.reviews)
                }
                
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if let selectedSalonId {
                Task {
                    await viewModel.getSpecialists(for: selectedSalonId)
                    await viewModel.getSalonDetail(for: selectedSalonId)
                    
                }
            }
        }
    }
}

