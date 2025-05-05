//
//  ContentView.swift
//  MyFirstSwiftUI App
//
//  Created by Unnikrishnan P on 4/25/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var showSplash  = true
    
    var hasSeenOnboarding: Bool {
        UserDefaults.standard.bool(forKey: "hasSeenOnboarding")
    }
    var hasAuthenticated: Bool {
        UserDefaults.standard.bool(forKey: "hasAuthenticated")
    }
    var body: some View {
        NavigationStack {
            if showSplash {
                SplashView()
                    .transition(.opacity)
//                    .animation(.linear(duration: 1.5))
            }else {
                if hasSeenOnboarding {
                    if hasAuthenticated {
                        MainTabView()
                    }else {
                        HomeView()
                    }
                    
                } else {
                    CorousalView()
                }
            }
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                self.showSplash = false
            })
        }
    }
}
