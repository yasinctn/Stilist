//
//  HomeViewModel.swift
//  Stilist
//
//  Created by Yasin Cetin on 3.12.2024.
//

import Foundation
import CoreLocation

@MainActor
final class HomeViewModel: ObservableObject {

    private let firestoreService: FirestoreServiceProtocol?
    @Published var salons: [Salon] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    init(firestoreService: FirestoreServiceProtocol? = FirestoreService()) {
        self.firestoreService = firestoreService
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
}
