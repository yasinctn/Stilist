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
    func createUser(name: String, email: String, phoneNumber: String, password: String, role: UserRole, completion: @escaping (Error?) -> Void)
    func signIn(email: String, password: String, completion: @escaping (Error?) -> Void)
    func signOut(completion: @escaping (Error?) -> Void)
}

final class AuthService: ObservableObject {
    @Published var currentUser : User?
    private let db = Firestore.firestore()
    
    init() {
        self.currentUser = Auth.auth().currentUser
        
        
    }
    
    
    private func writeUserData(_ user: AppUser, completion: @escaping (Error?) -> Void) {
        let collectionPath = user.userRole.rawValue
        guard let userID = user.id else { return }
        let userData: [String: Any] = [
            "id" : userID,
            "name" : user.name,
            "email" : user.email,
            "phoneNumber" : user.phoneNumber,
            "userRole" : user.userRole.rawValue
            
        ]
        
        db.collection(collectionPath).document(userID).setData(userData) { error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
        
    }
}


extension AuthService: AuthServiceProtocol {
    func createUser(name: String, email: String, phoneNumber: String, password: String, role: UserRole, completion: @escaping ((any Error)?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self else { return }
            if let error = error {
                completion(error)
                print("Error creating user: \(error.localizedDescription)")
            } else {
                let newUser = AppUser(id: result!.user.uid, name: name, email: email, phoneNumber: phoneNumber, userRole: role)
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
                self.currentUser = Auth.auth().currentUser
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
                self.currentUser = Auth.auth().currentUser
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
