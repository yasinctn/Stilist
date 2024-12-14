//
//  Salon.swift
//  Stilist
//
//  Created by Yasin Cetin on 13.12.2024.
//

import Foundation
import CoreLocation

struct Salon: Identifiable {
    let id = UUID()
    let name: String
    let address: String
    let distance: String
    let rating: String
    let coordinate: CLLocationCoordinate2D
    let imageName: String
}

struct aSalon: Identifiable, Codable {
    let id: String
    let name: String
    let address: String
    let distance: String // Kullanıcının konumuna göre hesaplanacak
    let rating: String
    let latitude: Double
    let longitude: Double
    let imageName: String
    let phoneNumber: String
    let description: String
    let saloonType: String
    let reviewCount: Int
    let isOpen: Bool
    let specialists: [Specialist]
    let workingHours: [WorkingHours]
    let services: [Service]
    let reviews: [Review]
    /*
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
     */
}

struct FirebaseSalon: Codable {
    let id: String
    let name: String
    let address: String
    let distance: String
    let rating: String
    let latitude: Double
    let longitude: Double
    let imageName: String
}

extension Salon {
    func toFirebaseSalon() -> FirebaseSalon {
        FirebaseSalon(
            id: id.uuidString,
            name: name,
            address: address,
            distance: distance,
            rating: rating,
            latitude: coordinate.latitude,
            longitude: coordinate.longitude,
            imageName: imageName
        )
    }
}
