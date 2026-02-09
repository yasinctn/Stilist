//
//  HomeView.swift
//  Stilist
//
//  Created by Yasin Cetin on 16.11.2024.
//

import SwiftUI
import CoreLocation
import MapKit

extension CLLocationCoordinate2D {
    // Some place in Miami
    static let coffeeShopCoordinate = CLLocationCoordinate2D(latitude: 25.865208, longitude: -80.121807)
}

struct HomeView: View {
    
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var salonDetailViewModel: SalonDetailViewModel
    @EnvironmentObject var messageViewModel: MessageViewModel
    @EnvironmentObject var appointmentViewModel: AppointmentViewModel
    @EnvironmentObject var chatViewModel: ChatViewModel
    
    @Binding var selectedTab: Tab
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                
                HStack {
                    Spacer()
                    Text("Stilist")
                        .font(.largeTitle)
                        .foregroundStyle(Color.orange)
                    Spacer()
                }
                
                
                // Greeting
                Text("Merhaba \(authViewModel.currentUser?.name ?? "opsiyonel")")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding()
                
                // Search Bar
                TextField("Ara", text: .constant(""))
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                
                
                //Map
                
                Map(initialPosition: .region(MKCoordinateRegion(center: locationManager.userLocation ?? .coffeeShopCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))) {
                    
                    Marker("siz", coordinate: locationManager.userLocation ?? .coffeeShopCoordinate)
                        .tint(.orange)
                }
                .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding()
                    .frame(height: 200)
                    .mapControlVisibility(.hidden)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            selectedTab = .explore
                        }
                        

                    }
                
                
                // Categories
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        CategoryButton(icon: "scissors", title: "Saç kesimi")
                        CategoryButton(icon: "wand.and.stars", title: "Makyaj")
                        CategoryButton(icon: "hand.raised", title: "Manikür")
                        CategoryButton(icon: "figure.walk", title: "Masaj")
                    }
                    .padding(.horizontal)
                }
                
                // Nearby Locations Section
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Yakınınızda")
                            .font(.headline)
                        Spacer()
                        Text("Tümünü gör")
                            .font(.subheadline)
                            .foregroundColor(.orange)
                    }
                    .padding(.horizontal)
                    
                    if homeViewModel.isLoading {
                        LoadingView()
                            .padding()
                    } else if homeViewModel.salons.isEmpty {
                        Text("Yakınında salon bulunamadı.")
                            .foregroundColor(.secondary)
                            .padding()
                    } else {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(homeViewModel.salons) { salon in
                                    NavigationLink {
                                        SalonDetailView(selectedSalonId: salon.id)
                                            .environmentObject(salonDetailViewModel)
                                            .environmentObject(authViewModel)
                                            .environmentObject(appointmentViewModel)
                                            .environmentObject(messageViewModel)
                                            .environmentObject(chatViewModel)
                                    } label: {
                                        NearbyCard(
                                            title: salon.name,
                                            address: salon.address,
                                            distance: salon.distance,
                                            rating: salon.rating
                                        )
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
            /*
            .onAppear(){
                homeViewModel.saveSalonsToFirebase(salons: homeViewModel.sampleSalons)
            }
            */
            .toolbar(.hidden)
        }
        .onAppear {
            Task {
                await homeViewModel.getSalons()
            }
        }
    }
}


