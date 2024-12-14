//
//  NearbyCard.swift
//  Stilist
//
//  Created by Yasin Cetin on 30.11.2024.
//

import SwiftUI

struct NearbyCard: View {
    var imageName: String
    var title: String
    var address: String
    var distance: String
    var rating: String
    
    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .frame(width: 80, height: 80)
                .cornerRadius(10)
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(address)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                HStack {
                    Text(distance)
                        .font(.footnote)
                        .foregroundColor(.gray)
                    Spacer()
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .font(.footnote)
                            .foregroundColor(.yellow)
                        Text(rating)
                            .font(.footnote)
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(15)
    }
}

