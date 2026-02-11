//
//  SalonDetailViewModel.swift
//  Stilist
//
//  Created by Yasin Cetin on 13.12.2024.
//

import Foundation

@MainActor
final class SalonDetailViewModel: ObservableObject {

    private var firestoreService: FirestoreServiceProtocol?

    @Published var salonDetail: SalonDetail?
    @Published var chatID: String?
    @Published var reviews: [Review] = []
    @Published var specialists: [Specialist] = []
    @Published var services: [Service] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    init(firestoreService: FirestoreServiceProtocol? = FirestoreService()) {
        self.firestoreService = firestoreService
    }

    func getSalonDetail(for salonId: String?) async {
        guard let salonId else {
            self.errorMessage = "Salon ID bulunamadı."
            return
        }

        isLoading = true
        do {
            let detail = try await firestoreService?.fetchSalonDetails(salonId: salonId)
            self.salonDetail = detail
            self.reviews = detail?.reviews ?? []
            self.specialists = detail?.specialists ?? []
            self.services = detail?.services ?? []
        } catch {
            self.errorMessage = "Salon bilgileri alınamadı: \(error.localizedDescription)"
        }
        isLoading = false
    }

    func getSpecialists(for salonId: String) async {
        do {
            self.specialists = try await firestoreService?.fetchSpecialists(salonId: salonId) ?? []
        } catch {
            self.errorMessage = "Uzmanlar alınamadı: \(error.localizedDescription)"
        }
    }
}
