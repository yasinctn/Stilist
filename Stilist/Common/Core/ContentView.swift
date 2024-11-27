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
    @StateObject private var chatViewModel = ChatViewModel(chatService: ChatService())
    @StateObject private var appointmentViewModel = AppointmentViewModel()
    
    
    var body: some View {
        
        
        if authViewModel.isSignedIn {
            
            TabViewContent()
                .environmentObject(appointmentViewModel)
                .environmentObject(navigationViewModel)
                .environmentObject(authViewModel)
                .environmentObject(chatViewModel)
            
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
