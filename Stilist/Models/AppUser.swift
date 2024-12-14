//
//  AppUser.swift
//  Stilist
//
//  Created by Yasin Cetin on 16.11.2024.
//

import Foundation
import FirebaseFirestore

struct AppUser: Identifiable {
    
    @DocumentID var id: String?
    let name: String
    let email: String
    let phoneNumber: String
    let profileImageURL: String = ""
    let userRole: UserRole
    
}
 
