//
//  SplashView.swift
//  MyFirstSwiftUI App
//
//  Created by Unnikrishnan P on 4/30/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            // Background color
            Color.blue
                .ignoresSafeArea()
            
            // Centered icon
            Image(systemName: "bolt.fill") // Use your custom image name if needed
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.white)
        }
    }
}

#Preview {
    SplashView()
}
