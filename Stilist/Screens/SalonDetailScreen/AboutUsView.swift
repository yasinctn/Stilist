//
//  AboutUsView.swift
//  Stilist
//
//  Created by Yasin Cetin on 15.12.2024.
//

import SwiftUI
import MapKit

struct AboutUsView: View {
    
    @State var salonDetail: SalonDetail?
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(salonDetail?.description ?? "")
                .padding(.top)
            
            // Çalışma Saatleri
            VStack(alignment: .leading, spacing: 5) {
                Text("Çalışma Saatleri")
                    .font(.headline)
                if let workingHours = salonDetail?.workingHours, !workingHours.isEmpty {
                    ForEach(workingHours) { hours in
                        HStack {
                            Text(hours.day ?? "")
                                .fontWeight(.medium)
                            Spacer()
                            Text("\(hours.openTime ?? "") - \(hours.closeTime ?? "")")
                        }
                    }
                } else {
                    Text("Bilgi mevcut değil")
                        .foregroundColor(.secondary)
                }
            }
            .padding(.top)
            
            // İletişim Bilgileri
            VStack(alignment: .leading, spacing: 5) {
                Text("İletişim")
                    .font(.headline)
                Text(salonDetail?.phoneNumber ?? "")
                Text(salonDetail?.address ?? "")
            }
            .padding(.top)
            
            Map(initialPosition: .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: salonDetail?.latitude ?? 0.0, longitude: salonDetail?.longitude ?? 0.0), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))) {
                Annotation(salonDetail?.name ?? "",
                           coordinate: CLLocationCoordinate2D(
                            latitude: salonDetail?.latitude ?? 0.0,
                            longitude: salonDetail?.longitude ?? 0.0)
                ) {
                    Button(action: {
                        
                    }) {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.orange)
                            .font(.title)
                    }
                    
                }
            }.frame(height: 200)
                .cornerRadius(10)
                .padding(.top)
        }
    }
}

#Preview {
    AboutUsView()
}
