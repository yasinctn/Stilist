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

@MainActor
final class ExploreViewModel: ObservableObject {

    private let firestoreService: FirestoreServiceProtocol?

    @Published var isSearchEnabled: Bool = false
    @Published var selectedSalon: Salon? = nil
    @Published var cameraPosition: MapCameraPosition = .automatic
    @Published var salons: [Salon] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    private var userLocation: CLLocationCoordinate2D?

    init(firestoreService: FirestoreServiceProtocol? = FirestoreService()) {
        self.firestoreService = firestoreService
    }

    func setUserLocation(_ location: CLLocationCoordinate2D) {
        userLocation = location
        if cameraPosition == .automatic {
            centerToUserLocation()
        }
    }

    func getSalons() async {
        isLoading = true
        do {
            self.salons = try await firestoreService?.fetchSalons() ?? []
        } catch {
            self.errorMessage = "Salonlar alınamadı: \(error.localizedDescription)"
        }
        isLoading = false
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
