//
//  AuthViewModel.swift
//  Stilist
//
//  Created by Yasin Cetin on 15.11.2024.
//

import SwiftUI
import FirebaseAuth

final class AuthViewModel: ObservableObject {
    
    private var authService: AuthServiceProtocol?
    private var dbService: FirestoreServiceProtocol?
    
    @Published var currentUser: AppUser?
    @Published var isSignedIn: Bool = false
    
    init(authService: AuthService? = AuthService(), dbService: FirestoreService? = FirestoreService()) {
        self.dbService = dbService
        self.authService = AuthService()
        self.setCurrentUser()
    }
    
    func setCurrentUser() {
        
        dbService?.getUserData(id: Auth.auth().currentUser?.uid, completion: { currentUser in
        
            guard let currentUser else { return }
            
            self.currentUser = currentUser
            
            
        })
    }
    
    // Kullanıcı Oluşturma
    func createUser(name: String, email: String, phoneNumber: String, password: String, role: UserRole, completion: @escaping (Error?) -> Void) {
        authService?.createUser(name: name, email: email, phoneNumber: phoneNumber, password: password, role: role, completion: { [ weak self ] error in
            guard let self else { return }
            if let error = error {
                print(error.localizedDescription)
                completion(error)
            }else {
                setCurrentUser()
                self.isSignedIn = true
                completion(nil)
            }
        })
    }
    
    // Oturum Açma
    func signIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
        authService?.signIn(email: email, password: password, completion: { [weak self] error in
            guard let self else { return }
            if let error = error {
                print(error.localizedDescription)
                completion(error)
            }else {
                setCurrentUser()
                self.isSignedIn = true
                completion(nil)
            }
        })
    }
    
    // Çıkış Yapma
    func signOut(completion: @escaping (Error?) -> Void) {
        authService?.signOut(completion: { [ weak self ] error in
            guard let self else { return }
            if let error = error {
                print(error.localizedDescription)
                completion(error)
            }else {
                self.isSignedIn = false
                completion(nil)
            }
        })
    }
}
    
