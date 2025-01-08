//
//  NearbyCard.swift
//  Stilist
//
//  Created by Yasin Cetin on 30.11.2024.
//

import SwiftUI

struct NearbyCard: View {
    var title: String
    var address: String
    var distance: String
    var rating: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(address)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                HStack {
                    Text(distance)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    Spacer()
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .font(.footnote)
                            .foregroundColor(.yellow)
                        Text(rating)
                            .font(.footnote)
                            .foregroundColor(.primary)
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(15)
    }
}

