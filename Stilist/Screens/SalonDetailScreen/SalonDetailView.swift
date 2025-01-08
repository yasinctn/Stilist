//
//  SalonDetailView.swift
//  Stilist
//
//  Created by Yasin Cetin on 26.11.2024.
//

import SwiftUI
import MapKit

struct SalonDetailView: View {
    
    @EnvironmentObject private var viewModel: SalonDetailViewModel
    
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
                                        senderID: AuthViewModel().currentUser?.uid,
                                        barberName: viewModel.salonDetail?.name
                             )
                                .environmentObject(MessageViewModel())
                        } label: {
                            Text("Mesaj")
                                .padding(7)
                                .frame(maxWidth: .infinity)
                                .background(Color.orange)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        
                        NavigationLink {
                            AppointmentView()
                                .environmentObject(AppointmentViewModel())
                                .environmentObject(AuthViewModel())
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
                            ForEach(viewModel.salonDetail?.specialists ?? []) { specialist in
                                VStack {
                                    Circle()
                                        .frame(width: 60, height: 60)
                                        .foregroundColor(.gray)
                                    Text(specialist.name ?? "")
                                        .font(.subheadline)
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
                
                
                switch selectedTab {
                case "Hakkımızda":
                    AboutUsView(salonDetail: viewModel.salonDetail)
                case "Hizmetler":
                    ServicesView(services: viewModel.services)
                case "Yorumlar":
                    ReviewsView(reviews: viewModel.reviews)
                default:
                    EmptyView()
                }
                
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.getSalonDetail(for: selectedSalonId)
        }
    }
}

#Preview {
    SalonDetailView()
        .environmentObject(ExploreViewModel())
}
