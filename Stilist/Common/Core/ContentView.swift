//
//  ContentView.swift
//  Stilist
//
//  Created by Yasin Cetin on 10.11.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var navigationViewModel = NavigationViewModel()
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some View {
        
        
        if authViewModel.isSignedIn {
            
            
            TabViewContent()
                .environmentObject(navigationViewModel)
                .environmentObject(authViewModel)
            
            
            
        } else {
            
            NavigationStack(path: $navigationViewModel.path) {
                EntryView()
                    .environmentObject(navigationViewModel)
                    .environmentObject(authViewModel)
                    .navigationDestination(for: String.self) { destination in
                        switch destination {
                        case "CreateAccount":
                            CreateAccountView()
                                .environmentObject(navigationViewModel)
                                .environmentObject(authViewModel)
                        case "FillProfileView":
                            FillProfileView()
                                .environmentObject(navigationViewModel)
                                .environmentObject(authViewModel)
                        case "LoginView":
                            LoginView()
                                .environmentObject(navigationViewModel)
                                .environmentObject(authViewModel)
                        default:
                            Text("Unknown Destination")
                        }
                    }
            }
            .animation(.easeInOut, value: authViewModel.isSignedIn)
            .transition(.slide)
        }
    }
}



#Preview {
    ContentView()
}
