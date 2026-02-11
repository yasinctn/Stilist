//
//  ExploreView.swift
//  Stilist
//
//  Created by Yasin Cetin on 17.11.2024.
//

import SwiftUI
import MapKit
import CoreLocation

// Main View
struct ExploreView: View {
    
    @EnvironmentObject private var locationManager: LocationManager
    @EnvironmentObject private var viewModel: ExploreViewModel
    @EnvironmentObject private var navigationViewModel: NavigationViewModel
    @EnvironmentObject private var authViewModel: AuthViewModel
    @EnvironmentObject private var salonDetailViewModel: SalonDetailViewModel
    @EnvironmentObject private var messageViewModel: MessageViewModel
    @EnvironmentObject private var appointmentViewModel: AppointmentViewModel
    @EnvironmentObject private var chatViewModel: ChatViewModel
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                if !viewModel.isSearchEnabled {
                    if viewModel.isLoading || locationManager.userLocation == nil {
                        LoadingView(locationManager.userLocation == nil ? "Konumunuz alınıyor..." : "Salonlar yükleniyor...")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else if viewModel.salons.isEmpty {
                        VStack(spacing: 12) {
                            Image(systemName: "mappin.slash")
                                .font(.system(size: 40))
                                .foregroundColor(.gray)
                            Text("Yakınında salon bulunamadı")
                                .font(.headline)
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        Map {
                            ForEach(viewModel.salons) { salon in
                                Annotation(salon.name, coordinate: salon.coordinate) {
                                    Button(action: {
                                        viewModel.selectedSalon = salon
                                    }) {
                                        Image(systemName: "mappin.circle.fill")
                                            .foregroundColor(.orange)
                                            .font(.title)
                                    }
                                }
                            }
                        }
                    }
                    
                }else {
                    //liste gelecek
                }
                
                // Search Bar
                VStack {
                    TextField("Ara", text: .constant(""))
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.top, 20)
                        .onTapGesture {
                            viewModel.isSearchEnabled.toggle()
                        }
                    
                    Spacer()
                    
                    // Salon Details
                    if let salon = viewModel.selectedSalon {
                        VStack(spacing: 10) {
                            Capsule()
                                .frame(width: 50, height: 5)
                                .foregroundStyle(Color.black)
                                .padding(.top, 10)
                            
                            Text("Detaylar")
                                .font(.headline)
                                .padding(.bottom, 5)
                                .foregroundStyle(Color.black)
                            
                            HStack(spacing: 15) {
                                
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(salon.name)
                                        .font(.headline)
                                        .foregroundStyle(Color.black)
                                    Text(salon.address)
                                        .font(.subheadline)
                                        .foregroundStyle(Color.gray)
                                    HStack {
                                        Text(salon.distance)
                                            .font(.subheadline)
                                            .foregroundColor(.orange)
                                        Spacer()
                                        Text("⭐ \(salon.rating)")
                                            .font(.subheadline)
                                            .foregroundColor(.orange)
                                    }
                                }
                                Spacer()
                                Button(action: {
                                    // Save action
                                }) {
                                    Image(systemName: "bookmark")
                                        .foregroundColor(.orange)
                                }
                            }
                            .padding(.horizontal)
                            
                            NavigationLink {
                                SalonDetailView(selectedSalonId: salon.id)
                                    .environmentObject(salonDetailViewModel)
                                    .environmentObject(authViewModel)
                                    .environmentObject(appointmentViewModel)
                                    .environmentObject(messageViewModel)
                                    .environmentObject(chatViewModel)
                            } label: {
                                Text("İncele")
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.orange)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .padding()
                            }
                        }
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 5)
                        .padding()
                    }
                }
            }
            .toolbar(.hidden, for: .navigationBar)
        }
        .onAppear {
            Task {
                await viewModel.getSalons()
            }
        }
        .errorAlert(message: $viewModel.errorMessage)
    }
}

#Preview {
    ExploreView()
}
