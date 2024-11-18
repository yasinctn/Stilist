//
//  StilistApp.swift
//  Stilist
//
//  Created by Yasin Cetin on 10.11.2024.
//

import SwiftUI
import FirebaseCore

@main
struct StilistApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
