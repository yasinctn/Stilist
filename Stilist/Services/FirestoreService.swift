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
    func fetchSalons(completion: @escaping (Result<[Salon], Error>) -> Void)
    func fetchSalonDetails(salonId: String, completion: @escaping (SalonDetail?) -> Void)
    func getUserData(id: String?, completion: @escaping (AppUser?) -> Void)
    func fetchSpecialists(salonId: String, completion: @escaping (Error?, [Specialist]?) -> Void) 
}

final class FirestoreService {
    private let db = Firestore.firestore()
}

extension FirestoreService: FirestoreServiceProtocol {
    
    func getUserData(id: String?, completion: @escaping (AppUser?) -> Void) {
        
        guard let id else {
            print("Kullanıcı id'si yok.")
            completion(nil)
            return
        }
        
        db.collection("users").whereField("id", isEqualTo: id).getDocuments { snapshot, error in
            if let error = error {
                print("Serviste hata: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let snapshot = snapshot, !snapshot.documents.isEmpty else {
                print("Kullanıcı bulunamadı.")
                completion(nil)
                return
            }
            
            // İlk dökümanı al ve AppUser'a dönüştür
            let document = snapshot.documents.first
            
            do {
                let appUser = try document?.data(as: AppUser.self)
                completion(appUser)
            } catch {
                print("Veri dönüştürme hatası: \(error)")
                completion(nil)
            }
        }
    }
    
    func fetchSalons(completion: @escaping (Result<[Salon], Error>) -> Void) {
        
        db.collection("salons").getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
                print("serviste hata: \(error.localizedDescription)")
            } else {
                
                guard let documents = snapshot?.documents else {
                    print("dökümanı alamadı")
                    return
                }
                
                let salons: [Salon] = documents.compactMap { doc in
                    let data = doc.data()
                    guard let id = data["id"] as? String,
                          let name = data["name"] as? String,
                          let address = data["address"] as? String,
                          let rating = data["rating"] as? String,
                          let latitude = data["latitude"] as? Double,
                          let longitude = data["longitude"] as? Double,
                          let imageName = data["imageName"] as? String else {
                        print("dönüştüremedi")
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
                completion(.success(salons))
            }
        }
    }
    
    func fetchSpecialists(salonId: String, completion: @escaping (Error?, [Specialist]?) -> Void) {
        
        self.db.collection("salons").document(salonId).collection("specialists").getDocuments { snapshot, error in
            
            if let error = error {
                print("Error fetching specialists: \(error.localizedDescription)")
                completion(error,nil)
            }else {
                guard let documents = snapshot?.documents else {
                    print("No documents found.")
                    completion(error, nil)
                    return
                }
                
                let specialists = documents.compactMap { doc -> Specialist? in
                    do {
                        let specialist = try doc.data(as: Specialist.self)
                        return specialist
                    } catch {
                        print("Veri dönüştürme hatası: \(error)")
                        return nil
                    }
                    
                }
                completion(nil, specialists)
            }
            
        }
    }
    
    func fetchSalonDetails(salonId: String, completion: @escaping (SalonDetail?) -> Void) {
        db.collection("salons").document(salonId).getDocument { snapshot, error in
            if let error = error {
                print("Detay hatası: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let document = snapshot else {
                print("Salon bulunamadı.")
                completion(nil)
                return
            }
            do {
                let salonDetail = try document.data(as: SalonDetail.self)
                completion(salonDetail)
            } catch {
                print("Veri dönüştürme hatası: \(error)")
                completion(nil)
            }
        }
    }
}
