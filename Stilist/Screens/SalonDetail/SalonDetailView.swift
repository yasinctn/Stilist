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
    
    @State var selectedSalonId: UUID? = nil
    @State private var selectedTab = "Hakkımızda"
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                HStack {
                    Text(selectedSalonId?.uuidString ?? "alamadık")
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
                Text(viewModel.salonDetail?.address ?? "Loading...")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                // Değerlendirme ve İkonlar
                VStack(alignment: .leading) {
                    HStack(spacing: 2) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("4.8")
                    }
                    Text("(3,279 yorum)")
                        .foregroundColor(.gray)
                    Spacer()
                    HStack {
                        
                        Image(systemName: "message")
                        Image(systemName: "phone")
                        Image(systemName: "location")
                        Image(systemName: "square.and.arrow.up")
                    }
                    .font(.system(size: 20))
                }
                .padding(.vertical)
                Divider()
                
                // Uzmanlarımız (Our Specialist) Bölümü
                VStack(alignment: .leading) {
                    Text("Our Specialist")
                        .font(.headline)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(0..<5) { _ in
                                VStack {
                                    Circle()
                                        .frame(width: 60, height: 60)
                                        .foregroundColor(.gray)
                                    Text("Name")
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
                
                // Seçilen Sekmeye Göre İçerik Gösterimi
                if selectedTab == "Hakkımızda" {
                    Text(viewModel.salonDetail?.description ?? "detay hatası")
                        .padding(.top)
                    
                    // Çalışma Saatleri
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Çalışma Saatleri")
                            .font(.headline)
                        Text("Hafta içi: 08:00 - 21:00")
                        Text("Hafta sonu: 10:00 - 20:00 ")
                    }
                    .padding(.top)
                    
                    // İletişim Bilgileri
                    VStack(alignment: .leading, spacing: 5) {
                        Text("İletişim")
                            .font(.headline)
                        Text("(406) 555 0120")
                        Text("6993 Meadow Valley Terrace, New York")
                    }
                    .padding(.top)
                    
                    // Harita Görünümü
                    Map(coordinateRegion: $region)
                        .frame(height: 200)
                        .cornerRadius(10)
                        .padding(.top)
                    
                    Button(action: {
                        
                    }) {
                        Text("Randevu al")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.top)
                } else if selectedTab == "Hizmetler"{
                    Text("Servisler")
                        .font(.headline)
                    VStack {
                        ForEach(["Hair Cut", "Hair Coloring", "Hair Wash", "Shaving", "Skin Care"], id: \.self) { service in
                            HStack {
                                Text(service)
                                Spacer()
                                Text("44 types")
                                    .foregroundColor(.gray)
                            }
                            Divider()
                        }
                    }
                } else if selectedTab == "Yorumlar" {
                    Text("Yorumlar")
                        .font(.headline)
                    VStack(spacing: 10) {
                        ForEach(viewModel.salonDetail?.reviews ?? []) { review in
                            HStack {
                                Circle()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.gray)
                                VStack(alignment: .leading) {
                                    Text(review.reviewerName)
                                        .font(.headline)
                                    Text(review.comment)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                VStack {
                                    Text(review.timeAgo)
                                    Image(systemName: "heart")
                                }
                            }
                            Divider()
                        }
                        
                    }
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            
        }
    }
}
#Preview {
    SalonDetailView()
        .environmentObject(ExploreViewModel())
}
