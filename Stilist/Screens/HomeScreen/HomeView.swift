//
//  HomeView.swift
//  Stilist
//
//  Created by Yasin Cetin on 16.11.2024.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        Text(authViewModel.currentUser?.email ?? "")
    }
}

