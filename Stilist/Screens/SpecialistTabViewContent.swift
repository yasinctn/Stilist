//
//  SpecialistTabViewContent.swift
//  Stilist
//
//  Created by Yasin Cetin on 11.01.2025.
//

import SwiftUI

struct SpecialistTabViewContent: View {
    
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var chatViewModel: ChatViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var appointmentViewModel: AppointmentViewModel
    @EnvironmentObject var salonDetailViewModel: SalonDetailViewModel
    @EnvironmentObject var exploreViewModel: ExploreViewModel
    @EnvironmentObject var specialistHomeViewModel: SpecialistHomeViewModel
    @EnvironmentObject var bookingsViewModel: BookingsViewModel

    @State var selectedTab: Tab = .home
    
    
    var body: some View {
        
        TabView (selection: $selectedTab) {
            
            // Home tab
            SpecialistHomeView()
                .environmentObject(navigationViewModel)
                .environmentObject(authViewModel)
                .environmentObject(specialistHomeViewModel)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(Tab.home)
            
            // My Booking tab
            MyBookingView()
                .environmentObject(navigationViewModel)
                .environmentObject(bookingsViewModel)
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
    SpecialistTabViewContent()
}
