//
//  SearchBar.swift
//  Stilist
//
//  Created by Yasin Cetin on 2026.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var placeholder: String = "Ara"

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField(placeholder, text: $text)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

#Preview {
    SearchBar(text: .constant(""))
}
