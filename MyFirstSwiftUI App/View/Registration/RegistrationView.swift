//
//  RegistrationView.swift
//  MyFirstSwiftUI App
//
//  Created by Unnikrishnan P on 4/30/25.
//

import Foundation
import SwiftUI

struct RegistrationView: View {
    var body: some View {
        VStack {
            WebView(url: URL(string: "https://www.apple.com/in/")!)
                .edgesIgnoringSafeArea(.bottom) // This makes sure the WebView fills the screen but respects the safe area top and sides
        }
    }
}
