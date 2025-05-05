//
//  LandingView.swift
//  MyFirstSwiftUI App
//
//  Created by Unnikrishnan P on 4/30/25.
//

import Foundation
import SwiftUI
struct LandingView: View {
    @State private var showLogoutAlert = false
    @State private var navigateToRegistration = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Button("Logout") {
                    showLogoutAlert = true
                }
                .font(.title2)
                .foregroundColor(.white)
                .padding()
                .frame(width: 200)
                .background(Color.red)
                .cornerRadius(12)
                
                Spacer()
            }
            .alert("Are you sure you want to logout?", isPresented: $showLogoutAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Logout", role: .destructive) {
                    // Clear state, user defaults etc.
                    UserDefaults.standard.set(false, forKey: "hasAuthenticated")
                    navigateToRegistration = true
                    // Switch to RegistrationView
                          switchRootView(to: HomeView())
                }
            }
            
//            // Navigate after logout
//            .navigationDestination(isPresented: $navigateToRegistration) {
//                RegistrationView()
//            }
        }
    }
    func switchRootView<Content: View>(to view: Content) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }

        window.rootViewController = UIHostingController(rootView: view)
        window.makeKeyAndVisible()
    }
}
