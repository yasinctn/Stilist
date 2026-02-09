//
//  LoadingView.swift
//  Stilist
//
//  Created by Yasin Cetin on 9.02.2025.
//

import SwiftUI

struct LoadingView: View {

    private let message: String

    init(_ message: String = "Yükleniyor...") {
        self.message = message
    }

    var body: some View {
        VStack(spacing: 12) {
            ProgressView()
            Text(message)
                .foregroundColor(.secondary)
                .font(.subheadline)
        }
    }
}

#Preview {
    LoadingView()
}
