//
//  ServicesView.swift
//  Stilist
//
//  Created by Yasin Cetin on 15.12.2024.
//

import SwiftUI

struct ServicesView: View {
    
    @State var services: [Service] = []
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Servisler")
                .font(.headline)
            VStack {
                ForEach(services) { service in
                    HStack {
                        Text(service.name ?? "")
                        Spacer()
                        Text(String(service.price ?? 0.0) + " ₺")
                            .foregroundColor(.gray)
                    }
                    Divider()
                }
            }
        }
    }
}

#Preview {
    ServicesView()
}
