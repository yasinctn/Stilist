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
    
    var body: some View {
        
        NavigationView {
            ZStack {
                if !viewModel.isSearchEnabled {
                    if let userLocation = locationManager.userLocation {
                        
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
                        
                        
                    } else {
                        Text("Fetching your location...")
                            .foregroundColor(.gray)
                            .font(.headline)
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
                                .foregroundColor(.gray)
                                .padding(.top, 10)
                            
                            Text("Detaylar")
                                .font(.headline)
                                .padding(.bottom, 5)
                            
                            HStack(spacing: 15) {
                                Image(salon.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60)
                                    .cornerRadius(8)
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(salon.name)
                                        .font(.headline)
                                    Text(salon.address)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
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
                            
                            Button(action: {
                                // Get directions action
                            }) {
                                Text("Get Direction")
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
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    ExploreView()
}
