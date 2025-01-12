//
//  AuthService.swift
//  Stilist
//
//  Created by Yasin Cetin on 20.11.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

protocol AuthServiceProtocol: AnyObject {
    func createUser(name: String, surname: String, email: String, phoneNumber: String, password: String, role: UserRole, completion: @escaping (Error?) -> Void)
    func addSpecialistToSalon(name: String, surname: String, email: String, phoneNumber: String, role: UserRole, salonID: String, completion: @escaping (Error?) -> Void)
    func signIn(email: String, password: String, completion: @escaping (Error?) -> Void)
    func signOut(completion: @escaping (Error?) -> Void)
}

final class AuthService: ObservableObject {
    
    @Published var user: User?
    @Published var currentUser : AppUser?
    private let db = Firestore.firestore()
    
    init() {
        self.user = Auth.auth().currentUser
    }
}


extension AuthService: AuthServiceProtocol {
    
    func createUser(name: String,surname: String, email: String, phoneNumber: String, password: String, role: UserRole, completion: @escaping ((any Error)?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self else { return }
            if let error = error {
                completion(error)
                print("Error creating user: \(error.localizedDescription)")
            } else {
                let newUser = AppUser(id: result!.user.uid, name: name, surname: surname, email: email, phoneNumber: phoneNumber, userRole: role)
                writeUserData(newUser) { error in
                    if let error = error {
                        completion(error)
                    }else {
                        completion(nil)
                    }
                }
                
                if let user = result?.user {
                    
                    let changeRequest = user.createProfileChangeRequest()
                    changeRequest.displayName = name
                    changeRequest.commitChanges { error in
                        completion(error)
                    }
                } else {
                    completion(nil)
                }
                self.currentUser = newUser
                completion(nil)
                print("User created successfully")
            }
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let self else { return }
            if let error = error {
                completion(error)
                print("Error signing in: \(error.localizedDescription)")
            } else {
                getUserData(id: Auth.auth().currentUser?.uid) { appUser in
                    self.currentUser = appUser
                }
                completion(nil)
                print("User signed in successfully")
            }
        }
    }
    
    func signOut(completion: @escaping ((any Error)?) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(nil)
            print("User signed out successfully")
        } catch let error {
            completion(error)
            print("Error signing out: \(error.localizedDescription)")
        }
    }
    
    
}
extension AuthService {
    
    private func getUserData(id: String?, completion: @escaping (AppUser?) -> Void) {
        
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
    
    private func writeUserData(_ user: AppUser, completion: @escaping (Error?) -> Void) {
        
        let collectionPath = "users"
        
        let userData: [String: Any] = [
            "id" : user.id,
            "name" : user.name,
            "surname" : user.surname,
            "email" : user.email,
            "phoneNumber" : user.phoneNumber,
            "userRole" : user.userRole.rawValue
            
        ]
        
        db.collection(collectionPath).document(user.id).setData(userData) { error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
        
    }
    
    func addSpecialistToSalon(name: String, surname: String, email: String, phoneNumber: String, role: UserRole, salonID: String, completion: @escaping (Error?) -> Void) {
        
        let specialist = Specialist(id: UUID().uuidString, name: name, surname: surname, email: email, phoneNumber: phoneNumber, salonId: salonID)
        
        let specialistData: [String: Any] = [
            "id" : specialist.id,
            "name" : specialist.name,
            "surname" : specialist.surname,
            "email" : specialist.email,
            "phoneNumber" : specialist.phoneNumber,
            "salonId" : specialist.salonId
            
        ]
        
        db.collection("salons").document(specialist.salonId).collection("specialists").document(specialist.id) .setData(specialistData) { error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
}
