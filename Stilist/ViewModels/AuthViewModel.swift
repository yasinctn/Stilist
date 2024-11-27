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
    
    @Published var currentUser: User?
    @Published var isSignedIn: Bool = false
    
    init(authService: AuthService? = AuthService()) {
        self.authService = AuthService()
        isSignedIn = currentUser != nil
    }
    
    // Kullanıcı Oluşturma
    func createUser(name: String, email: String, phoneNumber: String, password: String, completion: @escaping (Error?) -> Void) {
        authService?.createUser(name: name, email: email, phoneNumber: phoneNumber, password: password, completion: { error in
            if let error = error {
                print(error.localizedDescription)
                completion(error)
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
                self.currentUser = Auth.auth().currentUser
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
                completion(nil)
                self.isSignedIn = false
            }
        })
    }
}
    
