//
//  ProfileView.swift
//  Stilist
//
//  Created by Yasin Cetin on 16.11.2024.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel 
    
    @State private var showAlert = false
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    
                    VStack(spacing: 10) {
                        Image(systemName: "person.crop.circle") 
                            .resizable()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                        
                        Text(authViewModel.currentUser?.name ?? "Loading...")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text(authViewModel.currentUser?.email ?? "Loading...")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 20)
                    
                    Divider()
                    
                    
                    List {
                        Section {
                            NavigationLink(destination: Text("Edit Profile View")) {
                                Label("Profili Düzenle", systemImage: "person.crop.circle")
                            }
                            NavigationLink(destination: Text("Notification Settings")) {
                                Label("Bildirimler", systemImage: "bell")
                            }
                            
                            NavigationLink(destination: Text("Security Settings")) {
                                Label("Güvenlik", systemImage: "lock")
                            }
                        }
                        
                        
                        Section {
                            NavigationLink(destination: Text("Privacy Policy")) {
                                Label("Gizlilik Politikası", systemImage: "doc.text")
                            }
                            NavigationLink(destination: Text("Invite Friends")) {
                                Label("Arkadaşını Davet Et", systemImage: "person.2")
                            }
                        }
                        
                        Section {
                            Button(action: {
                                authViewModel.signOut { error in
                                    if let error {
                                        errorMessage = error.localizedDescription
                                        showAlert = true
                                    }
                                }
                            }) {
                                Label("Çıkış Yap", systemImage: "arrow.backward.square")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                }
                
                AlertView(isPresented: $showAlert, message: errorMessage)
            }
            
        }
    }
}

#Preview {
    ProfileView()
}
