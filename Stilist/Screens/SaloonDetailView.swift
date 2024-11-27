//
//  SaloonDetailView.swift
//  Stilist
//
//  Created by Yasin Cetin on 26.11.2024.
//

import SwiftUI
import MapKit

struct SaloonDetailView: View {
    @State private var selectedTab = "About us"
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // Başlık ve İkonlar Bölümü
                HStack {
                    Text("Barbarella Inova")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    Text("Open")
                        .foregroundColor(.green)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(10)
                }
                Text("6993 Meadow Valley Terrace, New York")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                // Değerlendirme ve İkonlar
                VStack(alignment: .leading) {
                    HStack(spacing: 2) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("4.8")
                    }
                    Text("(3,279 reviews)")
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
                        ForEach(["About us", "Services", "Package", "Gallery", "Review"], id: \.self) { tab in
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
                if selectedTab == "About us" {
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eu quam sodales...")
                        .padding(.top)
                    
                    // Çalışma Saatleri
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Working Hours")
                            .font(.headline)
                        Text("Monday - Friday: 08:00 AM - 21:00 PM")
                        Text("Saturday - Sunday: 10:00 AM - 20:00 PM")
                    }
                    .padding(.top)
                    
                    // İletişim Bilgileri
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Contact us")
                            .font(.headline)
                        Text("(406) 555-0120")
                        Text("6993 Meadow Valley Terrace, New York")
                    }
                    .padding(.top)
                    
                    // Harita Görünümü
                    Map(coordinateRegion: $region)
                        .frame(height: 200)
                        .cornerRadius(10)
                        .padding(.top)
                    
                    Button(action: {
                        // Harita ile ilgili bir işlem yapılabilir
                    }) {
                        Text("See on Maps")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.top)
                }else if selectedTab == "Services"{
                    Text("Our Services")
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
                } else if selectedTab == "Package" {
                    Text("Our Package")
                        .font(.headline)
                    VStack(spacing: 10) {
                        ForEach(["Haircut & Hairstyle", "Beauty Make Up", "Haircut & Hair Coloring"], id: \.self) { package in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(package)
                                        .font(.headline)
                                    Text("Special Offers Package")
                                        .foregroundColor(.gray)
                                        .font(.subheadline)
                                }
                                Spacer()
                                Button(action: {}) {
                                    Text("Book Now")
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 8)
                                        .background(Color.orange)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                            }
                            Divider()
                        }
                    }
                } else if selectedTab == "Gallery" {
                    Text("Our Gallery")
                        .font(.headline)
                    LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 3), spacing: 10) {
                        ForEach(0..<9) { _ in
                            Rectangle()
                                .frame(height: 100)
                                .foregroundColor(.gray)
                        }
                    }
                } else if selectedTab == "Review" {
                    Text("Reviews")
                        .font(.headline)
                    VStack(spacing: 10) {
                        ForEach(0..<5) { _ in
                            HStack {
                                Circle()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.gray)
                                VStack(alignment: .leading) {
                                    Text("Reviewer Name")
                                        .font(.headline)
                                    Text("Review content goes here. This is a placeholder for a review.")
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                VStack {
                                    Text("2m ago")
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
    }
}
#Preview {
    SaloonDetailView()
}
