//
//  HomeViewModel.swift
//  Stilist
//
//  Created by Yasin Cetin on 3.12.2024.
//

import Foundation
import CoreLocation
import FirebaseFirestore

final class HomeViewModel: ObservableObject {
    
    private let firestoreService: FirestoreServiceProtocol?
    @Published var salons: [Salon] = []
    
    init(firestoreService: FirestoreServiceProtocol? = FirestoreService()) {
        self.firestoreService = firestoreService
    }
    
    
    func getSalons() async {
        firestoreService?.fetchSalons { result in
            
            switch result {
                case .success(let salons):
                DispatchQueue.main.async {
                    self.salons = salons
                }
                case .failure(let error):
                print("Salonlar alınamadı: \(error.localizedDescription)")
            }
        }
    }
    
    /*
    let sampleSalons: [aSalon] = [
        aSalon(
            id: "1",
            name: "Engin Kuaför",
            address: "Sabuni Mahallesi Tekke Bayırı Sokak, Edirne",
            distance: "5 km", // Kullanıcının konumuna göre hesaplanacak
            rating: 4.5,
            latitude: 41.6761,
            longitude: 26.5578,
            imageName: "engin_kuafor_image",
            phoneNumber: "+90 212 345 67 89",
            description: "Bayan kuaför hizmetleri sunmaktadır.",
            saloonType: "Bayan Kuaförü",
            reviewCount: 120,
            isOpen: true,
            specialists: [
                Specialist(id: UUID(), name: "Engin Demirci", expertise: "Saç Kesimi", imageName: "engin_image", unavailability: nil)
            ],
            workingHours: [
                WorkingHours(day: "Monday", openTime: "08:00 AM", closeTime: "09:00 PM"),
                WorkingHours(day: "Tuesday", openTime: "08:00 AM", closeTime: "09:00 PM")
            ],
            services: [
                Service(id: "1", name: "Saç Kesimi", description: "Profesyonel saç kesimi", price: 50.0),
                Service(id: "2", name: "Saç Boyama", description: "Renkli saç boyama", price: 80.0)
            ],
            reviews: [
                Review(id: "1", reviewerName: "Ahmet Y.", profileImageURL: "ahmet_image", rating: 4.5, comment: "Harika hizmet.", timeAgo: "1 gün önce")
            ]
        ),
        
        aSalon(
            id: "2",
            name: "Kuaför Vicdan ve İsa",
            address: "Sabuni Mahallesi Yeni Çarşı Sokak, Edirne",
            distance: "3 km", // Kullanıcının konumuna göre hesaplanacak
            rating: 4.0,
            latitude: 41.6723,
            longitude: 26.5645,
            imageName: "vicdan_kuafor_image",
            phoneNumber: "+90 212 345 67 90",
            description: "Bayan kuaför hizmetleri.",
            saloonType: "Bayan Kuaförü",
            reviewCount: 85,
            isOpen: true,
            specialists: [
                Specialist(id: UUID(), name: "İsa Dönmez", expertise: "Saç Boyama", imageName: "isa_image", unavailability: nil)
            ],
            workingHours: [
                WorkingHours(day: "Monday", openTime: "09:00 AM", closeTime: "08:00 PM"),
                WorkingHours(day: "Tuesday", openTime: "09:00 AM", closeTime: "08:00 PM")
            ],
            services: [
                Service(id: "1", name: "Saç Boyama", description: "Renkli saç boyama", price: 70.0),
                Service(id: "2", name: "Manikür", description: "El bakımı", price: 30.0)
            ],
            reviews: [
                Review(id: "1", reviewerName: "Mehmet B.", profileImageURL: "mehmet_image", rating: 4.0, comment: "Güzel hizmet.", timeAgo: "2 gün önce")
            ]
        ),
        
        aSalon(
            id: "3",
            name: "Angel Kuaför",
            address: "1. Murat Mahallesi Güngör Mazlum Caddesi, Edirne",
            distance: "2 km", // Kullanıcının konumuna göre hesaplanacak
            rating: 4.8,
            latitude: 41.6800,
            longitude: 26.5599,
            imageName: "angel_kuafor_image",
            phoneNumber: "+90 212 345 67 91",
            description: "Saç kesimi, boyama, manikür, pedikür gibi çeşitli hizmetler.",
            saloonType: "Unisex Kuaför",
            reviewCount: 200,
            isOpen: true,
            specialists: [
                Specialist(id: UUID(), name: "Caner Güler", expertise: "Saç Kesimi", imageName: "caner_image", unavailability: nil)
            ],
            workingHours: [
                WorkingHours(day: "Monday", openTime: "08:00 AM", closeTime: "07:00 PM"),
                WorkingHours(day: "Tuesday", openTime: "08:00 AM", closeTime: "07:00 PM")
            ],
            services: [
                Service(id: "1", name: "Saç Kesimi", description: "Kısa saç kesimi", price: 55.0),
                Service(id: "2", name: "Manikür", description: "Yumuşak ve sağlıklı eller", price: 40.0)
            ],
            reviews: [
                Review(id: "1", reviewerName: "Zeynep A.", profileImageURL: "zeynep_image", rating: 5.0, comment: "Mükemmel!", timeAgo: "3 gün önce")
            ]
        )
    ]
    */
    
    /*
    func saveSalonsToFirebase(salons: [aSalon]) {
        let db = Firestore.firestore()
        let collection = db.collection("salons")
        
        for salon in salons {
            let firebaseSalon = salon
            do {
                try collection.document(UUID().uuidString).setData(from: firebaseSalon)
                print("Successfully added \(firebaseSalon.name) to Firebase.")
            } catch {
                print("Error saving \(firebaseSalon.name): \(error.localizedDescription)")
            }
        }
    }
    */
        
}
