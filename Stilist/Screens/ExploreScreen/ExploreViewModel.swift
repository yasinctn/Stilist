//
//  ExploreViewModel.swift
//  Stilist
//
//  Created by Yasin Cetin on 8.12.2024.
//

import Foundation
import CoreLocation
import MapKit
import _MapKit_SwiftUI

final class ExploreViewModel: ObservableObject {
    
    private let firestoreService: FirestoreServiceProtocol?
    
    @Published var isSearchEnabled: Bool = false
    @Published var selectedSalon: Salon? = nil
    @Published var cameraPosition: MapCameraPosition = .automatic 
    @Published var salons: [Salon] = []
    private var userLocation: CLLocationCoordinate2D?
    
    init(firestoreService: FirestoreServiceProtocol? = FirestoreService()) {
        self.firestoreService = firestoreService
        getSalons()
    }
    
    func setUserLocation(_ location: CLLocationCoordinate2D) {
        userLocation = location
        if cameraPosition == .automatic {
            centerToUserLocation()
        }
    }
    
    private func getSalons() {
        firestoreService?.fetchSalons { salons in
            if let salons = salons {
                DispatchQueue.main.async {
                    self.salons = salons
                    print("yenilendi")
                }
            } else {
                print("Salonlar alınamadı")
            }
        }
    }
    
    func centerToSalon(_ salon: Salon) {
        cameraPosition = .region(MKCoordinateRegion(
            center: salon.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        ))
    }
    
    func centerToUserLocation() {
        guard let location = userLocation else { return }
        cameraPosition = .region(MKCoordinateRegion(
            center: location,
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        ))
    }
}
