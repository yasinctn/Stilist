//
//  AuthViewModel.swift
//  Stilist
//
//  Created by Yasin Cetin on 15.11.2024.
//

import SwiftUI
import FirebaseAuth

@MainActor
final class AuthViewModel: ObservableObject {

    private var authService: AuthServiceProtocol?
    private var dbService: FirestoreServiceProtocol?

    @Published var currentUser: AppUser?
    @Published var isSignedIn: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    init(authService: AuthServiceProtocol? = AuthService(), dbService: FirestoreServiceProtocol? = FirestoreService()) {
        self.dbService = dbService
        self.authService = authService
        self.isSignedIn = Auth.auth().currentUser != nil
        Task { await setCurrentUser() }
    }

    func setCurrentUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        do {
            self.currentUser = try await dbService?.getUserData(id: uid)
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }

    func createUser(name: String, surname: String, email: String, phoneNumber: String, password: String, role: UserRole) async {
        isLoading = true
        do {
            let user = try await authService?.createUser(name: name, surname: surname, email: email, phoneNumber: phoneNumber, password: password, role: role)
            self.currentUser = user
            self.isSignedIn = true
        } catch {
            self.errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    func saveSpecialistToSalon(name: String, surname: String, email: String, phoneNumber: String, role: UserRole, salonID: String) async {
        do {
            try await authService?.addSpecialistToSalon(name: name, surname: surname, email: email, phoneNumber: phoneNumber, role: role, salonID: salonID)
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }

    func signIn(email: String, password: String) async {
        isLoading = true
        do {
            try await authService?.signIn(email: email, password: password)
            await setCurrentUser()
            self.isSignedIn = true
        } catch {
            self.errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    func signOut() {
        do {
            try authService?.signOut()
            self.currentUser = nil
            self.isSignedIn = false
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
}
