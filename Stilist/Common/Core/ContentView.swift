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
    @StateObject private var specialistHomeViewModel = SpecialistHomeViewModel(bookingService: BookingService())
    @StateObject private var messageViewModel = MessageViewModel(chatService: ChatService())
    @StateObject private var bookingsViewModel = BookingsViewModel(bookingService: BookingService())
    
    var body: some View {
        
        
        if authViewModel.isSignedIn {

            if let userRole = authViewModel.currentUser?.userRole {
                switch userRole {
                case .customer:
                    TabViewContent()
                        .environmentObject(locationManager)
                        .environmentObject(appointmentViewModel)
                        .environmentObject(navigationViewModel)
                        .environmentObject(authViewModel)
                        .environmentObject(chatViewModel)
                        .environmentObject(homeViewModel)
                        .environmentObject(salonDetailViewModel)
                        .environmentObject(exploreViewModel)
                        .environmentObject(messageViewModel)
                        .environmentObject(bookingsViewModel)
                        .animation(.easeInOut, value: authViewModel.isSignedIn)
                        .transition(.slide)
                case .specialist:
                    SpecialistTabViewContent()
                        .environmentObject(appointmentViewModel)
                        .environmentObject(navigationViewModel)
                        .environmentObject(authViewModel)
                        .environmentObject(chatViewModel)
                        .environmentObject(homeViewModel)
                        .environmentObject(salonDetailViewModel)
                        .environmentObject(exploreViewModel)
                        .environmentObject(specialistHomeViewModel)
                        .environmentObject(bookingsViewModel)
                        .animation(.easeInOut, value: authViewModel.isSignedIn)
                        .transition(.slide)
                case .admin:
                    AdminTabViewContent()
                        .environmentObject(appointmentViewModel)
                        .environmentObject(navigationViewModel)
                        .environmentObject(authViewModel)
                        .environmentObject(chatViewModel)
                        .environmentObject(homeViewModel)
                        .environmentObject(salonDetailViewModel)
                        .environmentObject(exploreViewModel)
                        .environmentObject(specialistHomeViewModel)
                        .environmentObject(bookingsViewModel)
                        .animation(.easeInOut, value: authViewModel.isSignedIn)
                        .transition(.slide)
                }
            } else {
                VStack(spacing: 16) {
                    ProgressView()
                        .scaleEffect(1.5)
                    Text("Yükleniyor...")
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
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
