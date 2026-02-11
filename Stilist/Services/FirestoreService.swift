//
//  FirestoreService.swift
//  Stilist
//
//  Created by Yasin Cetin on 13.12.2024.
//

import Foundation
import CoreLocation
import FirebaseFirestore

protocol FirestoreServiceProtocol: AnyObject {
    func fetchSalons() async throws -> [Salon]
    func fetchSalonDetails(salonId: String) async throws -> SalonDetail
    func getUserData(id: String) async throws -> AppUser
    func fetchSpecialists(salonId: String) async throws -> [Specialist]
}

final class FirestoreService: FirestoreServiceProtocol {
    private let db = Firestore.firestore()

    func getUserData(id: String) async throws -> AppUser {
        let snapshot = try await db.collection("users").whereField("id", isEqualTo: id).getDocuments()

        guard let document = snapshot.documents.first else {
            throw NSError(domain: "FirestoreService", code: 404, userInfo: [NSLocalizedDescriptionKey: "Kullanıcı bulunamadı."])
        }

        return try document.data(as: AppUser.self)
    }

    func fetchSalons() async throws -> [Salon] {
        let snapshot = try await db.collection("salons").getDocuments()

        return snapshot.documents.compactMap { doc in
            let data = doc.data()
            guard let id = data["id"] as? String,
                  let name = data["name"] as? String,
                  let address = data["address"] as? String,
                  let rating = data["rating"] as? String,
                  let latitude = data["latitude"] as? Double,
                  let longitude = data["longitude"] as? Double,
                  let imageName = data["imageName"] as? String else {
                return nil
            }

            return Salon(
                id: id,
                name: name,
                address: address,
                distance: "",
                rating: rating,
                coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                imageName: imageName
            )
        }
    }

    func fetchSpecialists(salonId: String) async throws -> [Specialist] {
        let snapshot = try await db.collection("salons").document(salonId).collection("specialists").getDocuments()

        return snapshot.documents.compactMap { doc in
            try? doc.data(as: Specialist.self)
        }
    }

    func fetchSalonDetails(salonId: String) async throws -> SalonDetail {
        let document = try await db.collection("salons").document(salonId).getDocument()

        guard document.exists else {
            throw NSError(domain: "FirestoreService", code: 404, userInfo: [NSLocalizedDescriptionKey: "Salon bulunamadı."])
        }

        return try document.data(as: SalonDetail.self)
    }
}
