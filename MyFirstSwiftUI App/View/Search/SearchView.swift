//
//  SearchView.swift
//  MyFirstSwiftUI App
//
//  Created by Unnikrishnan P on 4/30/25.
//

import SwiftUI
struct SearchView: View {
    var body: some View {
        WebView(url: URL(string: "https://www.apple.com/in/")!)
                  .edgesIgnoringSafeArea(.all) // Fullsc
    }
}
