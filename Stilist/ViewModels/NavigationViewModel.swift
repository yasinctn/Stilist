//
//  NavigationViewModel.swift
//  Stilist
//
//  Created by Yasin Cetin on 15.11.2024.
//

import SwiftUI

class NavigationViewModel: ObservableObject {
    @Published var path: [String] = []
    
    // Ekran geçişleri için bir işlev
    func navigateTo(_ destination: String) {
        path.append(destination)
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
