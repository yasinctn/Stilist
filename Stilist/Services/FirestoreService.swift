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
    func fetchSalons(completion: @escaping ([Salon]?) -> Void)
    func fetchSalonDetails(salonId: UUID, completion: @escaping (SalonDetail?) -> Void)
}

final class FirestoreService {
    private let db = Firestore.firestore()
    
}

extension FirestoreService: FirestoreServiceProtocol {
    
    func fetchSalons(completion: @escaping ([Salon]?) -> Void) {
        
        db.collection("salons").getDocuments { snapshot, error in
            if let error = error {
                completion(nil)
                print("serviste hata: \(error.localizedDescription)")
            } else {
                
                guard let documents = snapshot?.documents else {
                    print("dökümanı alamadı")
                    return
                }
                
                let salons: [Salon] = documents.compactMap { doc in
                    let data = doc.data()
                    guard let name = data["name"] as? String,
                          let address = data["address"] as? String,
                          let rating = data["rating"] as? String,
                          let latitude = data["latitude"] as? Double,
                          let longitude = data["longitude"] as? Double,
                          let imageName = data["imageName"] as? String else {
                        print("dönüştüremedi")
                        return nil
                    }
                    
                    return Salon(
                        name: name,
                        address: address,
                        distance: "",
                        rating: rating,
                        coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                        imageName: imageName
                    )
                }
                completion(salons)
            }
        }
    }
    
    func fetchSalonDetails(salonId: UUID, completion: @escaping (SalonDetail?) -> Void) {
        db.collection("salons").document(salonId.uuidString).getDocument { snapshot, error in
            if let error {
                print("detay hatası: \(error.localizedDescription)")
            }else {
                do {
                    var salonDetail = try snapshot?.data(as: SalonDetail.self)
                    completion(salonDetail)
                }catch {
                    completion(nil)
                    print("decode error")
                }
                
            }
        }
    }
}
