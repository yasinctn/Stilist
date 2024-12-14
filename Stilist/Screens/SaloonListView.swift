//
//  SaloonListView.swift
//  Stilist
//
//  Created by Yasin Cetin on 28.11.2024.
//

import SwiftUI
import MapKit

struct SalonListView: View {
    @State private var searchQuery: String = ""
    
    
    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                HStack {
                    TextField("Salon", text: $searchQuery)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    Button(action: {
                        // Search action
                    }) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding(.trailing)
                    }
                }
                .padding(.top)
                
                // Results Header
                HStack {
                    Text("Results \"\(searchQuery)\"")
                        .font(.headline)
                    Spacer()
                    Text("12,289 founds")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                .padding(.top, 5)
                
                // Salon List
                /*
                List(salons) { salon in
                    SalonRow(salon: salon)
                        .listRowInsets(EdgeInsets())
                        .padding(.horizontal)
                }
                .listStyle(PlainListStyle())
                 */
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct SalonRow: View {
    let salon: Salon
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
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
        .padding(.vertical, 8)
    }
}

#Preview{
    SalonListView()
}
