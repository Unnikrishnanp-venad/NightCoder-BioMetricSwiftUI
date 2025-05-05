//
//  MainTabView.swift
//  MyFirstSwiftUI App
//
//  Created by Unnikrishnan P on 4/30/25.
//

import Foundation
import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
           
            RegistrationView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            SettingsView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
            LandingView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }

        }.navigationBarBackButtonHidden(true) // Hide back button
    }
}
