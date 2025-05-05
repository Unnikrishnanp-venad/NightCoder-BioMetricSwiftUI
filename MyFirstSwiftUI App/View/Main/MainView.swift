//
//  MainView.swift
//  MyFirstSwiftUI App
//
//  Created by Unnikrishnan P on 5/5/25.
//

import SwiftUI

struct MainView: View {
    @State var isOpenSideMenu: Bool = false
    @State var text = "Hello, World!"
    
    var body: some View {
        ZStack{
            NavigationView {
                Text(text)
                    .navigationBarTitle("メイン画面")
                    .navigationBarItems(leading: (
                        Button(action: {
                            self.isOpenSideMenu.toggle()
                        }) {
                            Image(systemName: "line.horizontal.3")
                                .imageScale(.large)
                        }))
            }
            
//            SideMenuView(isOpen: $isOpenSideMenu, text: $text)
                .edgesIgnoringSafeArea(.all)
        }
    }
}
