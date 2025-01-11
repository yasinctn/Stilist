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
    @StateObject private var locationManager = LocationManager()
    @StateObject private var homeViewModel = HomeViewModel(firestoreService: FirestoreService())
    @StateObject private var salonDetailViewModel = SalonDetailViewModel(firestoreService: FirestoreService())
    @StateObject private var exploreViewModel = ExploreViewModel(firestoreService: FirestoreService())
    
    
    var body: some View {
        
        
        if authViewModel.isSignedIn {
            
            if authViewModel.currentUser?.userRole == .customer {
                
                TabViewContent()
                    .environmentObject(locationManager)
                    .environmentObject(appointmentViewModel)
                    .environmentObject(navigationViewModel)
                    .environmentObject(authViewModel)
                    .environmentObject(chatViewModel)
                    .environmentObject(homeViewModel)
                    .environmentObject(salonDetailViewModel)
                    .environmentObject(exploreViewModel)
                    .animation(.easeInOut, value: authViewModel.isSignedIn)
                    .transition(.slide)
            }
            else if authViewModel.currentUser?.userRole == .specialist {
                TabViewContent()
                    .environmentObject(locationManager)
                    .environmentObject(appointmentViewModel)
                    .environmentObject(navigationViewModel)
                    .environmentObject(authViewModel)
                    .environmentObject(chatViewModel)
                    .environmentObject(homeViewModel)
                    .environmentObject(salonDetailViewModel)
                    .environmentObject(exploreViewModel)
                    .animation(.easeInOut, value: authViewModel.isSignedIn)
                    .transition(.slide)
            }
            

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
                            
                        case "CreateSaloonAccount":
                            CreateSaloonAccountView()
                                .environmentObject(locationManager)
                                .environmentObject(navigationViewModel)
                                .environmentObject(authViewModel)
                        case "CreateSpecialistAccount":
                            CreateSpecialistAccountView()
                                .environmentObject(locationManager)
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
