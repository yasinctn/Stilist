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
    func createUser(name: String, surname: String, email: String, phoneNumber: String, password: String, role: UserRole) async throws -> AppUser
    func addSpecialistToSalon(name: String, surname: String, email: String, phoneNumber: String, role: UserRole, salonID: String) async throws
    func signIn(email: String, password: String) async throws
    func signOut() throws
}

final class AuthService: ObservableObject {

    @Published var user: User?
    @Published var currentUser: AppUser?
    private let db = Firestore.firestore()

    init() {
        self.user = Auth.auth().currentUser
    }
}

extension AuthService: AuthServiceProtocol {

    func createUser(name: String, surname: String, email: String, phoneNumber: String, password: String, role: UserRole) async throws -> AppUser {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)

        let newUser = AppUser(
            id: result.user.uid,
            name: name,
            surname: surname,
            email: email,
            phoneNumber: phoneNumber,
            userRole: role
        )

        try await writeUserData(newUser)

        let changeRequest = result.user.createProfileChangeRequest()
        changeRequest.displayName = name
        try await changeRequest.commitChanges()

        self.currentUser = newUser
        return newUser
    }

    func signIn(email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }

    func signOut() throws {
        try Auth.auth().signOut()
    }
}

extension AuthService {

    private func writeUserData(_ user: AppUser) async throws {
        let userData: [String: Any] = [
            "id": user.id,
            "name": user.name,
            "surname": user.surname,
            "email": user.email,
            "phoneNumber": user.phoneNumber,
            "userRole": user.userRole.rawValue
        ]

        try await db.collection("users").document(user.id).setData(userData)
    }

    func addSpecialistToSalon(name: String, surname: String, email: String, phoneNumber: String, role: UserRole, salonID: String) async throws {
        let specialist = Specialist(id: UUID().uuidString, name: name, surname: surname, email: email, phoneNumber: phoneNumber, salonId: salonID)

        let specialistData: [String: Any] = [
            "id": specialist.id,
            "name": specialist.name,
            "surname": specialist.surname,
            "email": specialist.email,
            "phoneNumber": specialist.phoneNumber,
            "salonId": specialist.salonId
        ]

        try await db.collection("salons").document(specialist.salonId)
            .collection("specialists").document(specialist.id).setData(specialistData)
    }
}
