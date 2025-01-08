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
    
    
    @State var selectedTab: Tab = .home
    
    
    var body: some View {
        
        
        TabView (selection: $selectedTab) {
            
            // Home tab
            HomeView(selectedTab: $selectedTab)
                .environmentObject(navigationViewModel)
                .environmentObject(authViewModel)
                .environmentObject(homeViewModel)
                .environmentObject(locationManager)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(Tab.home)
            // Explore tab
            ExploreView()
                .environmentObject(locationManager)
                .environmentObject(navigationViewModel)
                .environmentObject(ExploreViewModel())
                .tabItem {
                    Image(systemName: "safari.fill")
                    Text("Explore")
                }
                .tag(Tab.explore)
            
            // My Booking tab
            MyBookingView()
                .environmentObject(navigationViewModel)
                .environmentObject(BookingsViewModel())
                .tabItem {
                    Image(systemName: "calendar")
                    Text("My Booking")
                }
                .tag(Tab.myBooking)
            
            // Inbox tab
            ChatsView()
                .environmentObject(navigationViewModel)
                .environmentObject(authViewModel)
                .environmentObject(chatViewModel)
                .tabItem {
                    Image(systemName: "bubble.left.and.bubble.right.fill")
                    Text("Inbox")
                }
                .tag(Tab.inbox)
            
            // Profile tab
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
                .tag(Tab.profile)
        }
    }
}

#Preview {
    TabViewContent()
}
