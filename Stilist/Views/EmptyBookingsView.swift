//
//  EmptyBookingsView.swift
//  Stilist
//
//  Created by Yasin Cetin on 13.01.2025.
//

import SwiftUI

struct EmptyBookingsView: View {
    var body: some View {
        VStack {
            Image(systemName: "text.page.slash.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 200)
            
            Text("Oluşturulmuş randevu bulunamadı")
        }
        
    }
}

#Preview {
    EmptyBookingsView()
}
