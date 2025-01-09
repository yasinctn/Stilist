//
//  SalonDetailViewModel.swift
//  Stilist
//
//  Created by Yasin Cetin on 13.12.2024.
//

import Foundation

final class SalonDetailViewModel: ObservableObject {
    
    private var firestoreService: FirestoreServiceProtocol?
    
    @Published var salonDetail: SalonDetail?
    @Published var chatID: String?
    @Published var reviews: [Review] = []
    @Published var specialists: [Specialist] = []
    @Published var services: [Service] = []
    
    init(firestoreService: FirestoreServiceProtocol? = FirestoreService()) {
        self.firestoreService = firestoreService
    }
    
    func getSalonDetail(for salonId: String?) {
        if let salonId {
            firestoreService?.fetchSalonDetails(salonId: salonId, completion: { salonDetail in
                DispatchQueue.main.async {
                    if let salonDetail {
                        self.salonDetail = salonDetail
                        self.reviews = salonDetail.reviews ?? []
                        self.specialists = salonDetail.specialists ?? []
                        self.services = salonDetail.services ?? []
                    }else {
                        print("salon hatası")
                    }
                }
                
            })
        }else {
            print("id yok")
        }
        
    }
    
}
