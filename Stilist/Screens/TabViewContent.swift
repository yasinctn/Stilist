//
//  TabViewContent.swift
//  Stilist
//
//  Created by Yasin Cetin on 16.11.2024.
//

import SwiftUI

struct TabViewContent: View {
    
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var chatViewModel: ChatViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var appointmentViewModel: AppointmentViewModel
    
    var body: some View {
        
        TabView {
            
            HomeView()
                .environmentObject(navigationViewModel)
                .environmentObject(authViewModel)
                .environmentObject(homeViewModel)
                .environmentObject(locationManager)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            ExploreView()
                .environmentObject(locationManager)
                .environmentObject(navigationViewModel)
                .environmentObject(ExploreViewModel())
                .tabItem {
                    Image(systemName: "safari.fill")
                    Text("Explore")
                }
            MyBookingView()
                .environmentObject(navigationViewModel)
                .environmentObject(BookingsViewModel())
                .tabItem {
                    Image(systemName: "calendar")
                    Text("My Booking")
                }
            
            InboxView()
                .environmentObject(navigationViewModel)
                .environmentObject(authViewModel)
                .environmentObject(chatViewModel)
                .tabItem {
                    Image(systemName: "bubble.left.and.bubble.right.fill")
                    Text("Inbox")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
        }
    }
}

#Preview {
    TabViewContent()
}
