//
//  AuthViewModel.swift
//  Stilist
//
//  Created by Yasin Cetin on 15.11.2024.
//

import SwiftUI
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var user: User?
    @Published var isSignedIn: Bool = false
    @Published var errorMessage: String?
    
    init() {
        let firebaseUser = Auth.auth().currentUser
        self.user = Auth.auth().currentUser
        
        isSignedIn = user != nil
    }
    
    // Kullanıcı Oluşturma
    func createUser(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self else { return }
            if let error = error {
                self.errorMessage = error.localizedDescription
                completion(error)
                print("Error creating user: \(error.localizedDescription)")
            } else {
                self.user = Auth.auth().currentUser
                self.isSignedIn = true
                completion(nil)
                print("User created successfully")
            }
        }
    }
    
    // Oturum Açma
    func signIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let self else { return }
            if let error = error {
                self.errorMessage = error.localizedDescription
                completion(error)
                print("Error signing in: \(error.localizedDescription)")
            } else {
                self.user = Auth.auth().currentUser
                self.isSignedIn = true
                completion(nil)
                print("User signed in successfully")
            }
        }
    }
    
    // Çıkış Yapma
    func signOut(completion: @escaping (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            self.user = nil
            self.isSignedIn = false
            completion(nil)
            print("User signed out successfully")
        } catch let error {
            completion(error)
            self.errorMessage = error.localizedDescription
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}
