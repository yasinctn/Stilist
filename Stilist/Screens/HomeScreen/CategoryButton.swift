//
//  CategoryButton.swift
//  Stilist
//
//  Created by Yasin Cetin on 30.11.2024.
//

import SwiftUI

struct CategoryButton: View {
    var icon: String
    var title: String
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(Color.orange.opacity(0.2))
                    .frame(width: 60, height: 60)
                Image(systemName: icon)
                    .font(.title)
                    .foregroundColor(.orange)
            }
            Text(title)
                .font(.footnote)
                .foregroundColor(.black)
        }
    }
}

