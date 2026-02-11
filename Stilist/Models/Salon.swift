//
//  Salon.swift
//  Stilist
//
//  Created by Yasin Cetin on 13.12.2024.
//

import Foundation
import CoreLocation

struct Salon: Identifiable {
    let id: String
    let name: String
    let address: String
    let distance: String
    let rating: String
    let coordinate: CLLocationCoordinate2D
    let imageName: String
}
