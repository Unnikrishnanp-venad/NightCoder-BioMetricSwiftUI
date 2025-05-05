//
//  MainTabView.swift
//  MyFirstSwiftUI App
//
//  Created by Unnikrishnan P on 4/30/25.
//

import Foundation
import SwiftUI

struct MainTabView: View {
    
    @State var presentSideMenu = false
    @State var selectedSideMenuTab = 0
    var body: some View {
        NavigationStack {
            ZStack{
                TabView {
                    RegistrationView()
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }
                    ContactsView()
                        .tabItem {
                            Label("Search", systemImage: "magnifyingglass")
                        }
                    GalleryGridView()
                        .tabItem {
                            Label("Gallery", systemImage: "photo")
                        }
                    LandingView()
                        .tabItem {
                            Label("Settings", systemImage: "gearshape")
                        }
                    
                } .navigationBarItems(leading: (
                    Button(action: {
                        
                        presentSideMenu =  presentSideMenu ? false : true
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .imageScale(.large)
                    }))
                SideMenu(isShowing: $presentSideMenu, content: AnyView(SideMenuView(selectedSideMenuTab: $selectedSideMenuTab, presentSideMenu: $presentSideMenu)))
            }
        }
    }
    
}
