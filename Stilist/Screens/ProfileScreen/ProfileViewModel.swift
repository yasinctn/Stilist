//
//  ProfileViewModel.swift
//  Stilist
//
//  Created by Yasin Cetin on 9.01.2025.
//

import Foundation

final class ProfileViewModel: ObservableObject {
    private let authViewModel: AuthViewModel
    @Published var user: AppUser?
    
    init(authViewModel: AuthViewModel = AuthViewModel()) {
        self.authViewModel = authViewModel
        setCurrentUser()
    }
    
    private func setCurrentUser() {
        if let currentUser = authViewModel.currentUser {
            self.user = currentUser
        }else {
            print("kullanıcı atanamadı")
        }
    }
    
    func signOut(completion: @escaping (Error?) -> Void) {
        authViewModel.signOut { error in
            if let error {
                completion(error)
            }else {
                completion(nil)
            }
        }
    }
    
}
