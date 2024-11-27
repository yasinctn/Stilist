//
//  NavigationViewModel.swift
//  Stilist
//
//  Created by Yasin Cetin on 15.11.2024.
//

import SwiftUI

final class NavigationViewModel: ObservableObject {
    @Published var path: [String] = []
    @Published var inboxPath: [String] = []
    
    // Ekran geçişleri için bir işlev
    func navigateTo(_ destination: String) {
        path.append(destination)
    }
    func navigate(_ destination: String) {
        inboxPath.append(destination)
    }
    
    // Geri dönme işlevi
    func goBack() {
        path.removeLast()
    }
    
    // Ana ekrana dönme işlevi
    func goToRoot() {
        path = []
    }
    
}
