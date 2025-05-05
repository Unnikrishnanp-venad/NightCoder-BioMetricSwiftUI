//
//  HomeView.swift
//  MyFirstSwiftUI App
//
//  Created by Unnikrishnan P on 4/30/25.
//


import SwiftUI
import SwiftData
import LocalAuthentication

struct HomeView: View {
    @State private var isAuthenticated = false
    @State private var authError = ""
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack(spacing: 20) {
                    // Image at the top
                    Image("app-intro-01") // Replace with your image name
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.4) // 60% width and 30% height
                        .padding(.top, 40)
                    
                    // Text Description
                    Text("Welcome to the Home Screen!")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                        .fontWeight(.bold)
                        .padding(.horizontal, 20)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    // First Button
                    Button(action: {
                        authenticate()
                    }) {
                        Text("Registration")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .frame(height: 50) // Fixed height
                            .background(Color.blue)
                            .cornerRadius(25)
                    }
                    .padding(.horizontal, 20)
                    
                    // Second Button
                    Button(action: {
                        if let url = URL(string: "https://www.apple.com/in/store?cid=aos-IN-kwgo-brand") {
                               UIApplication.shared.open(url)
                           }
                    }) {
                        Text("Authentication")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .frame(height: 50) // Fixed height
                            .background(Color.blue)
                            .cornerRadius(25)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                }
                .background(Color(.systemBackground)) // Background color
                .navigationBarBackButtonHidden(true) // Hide back button
                .alert(alertTitle, isPresented: $showAlert) {
                    Button("OK", role: .cancel) {}
                } message: {
                    Text(alertMessage)
                }
                .navigationDestination(isPresented: $isAuthenticated) {
                    MainTabView() // Navigate to HomeView
                }
            }
        }
    }
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        // Check if biometric authentication is available
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate to continue"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authError in
                DispatchQueue.main.async {
                    if success {
                        UserDefaults.standard.set(true, forKey: "hasAuthenticated")
                        self.isAuthenticated = true
                        alertTitle = "Success"
                        alertMessage = "Operation completed successfully."
                    } else {
                        self.authError = authError?.localizedDescription ?? "Authentication failed"
                        alertTitle = "Error"
                        alertMessage = "Something went wrong. Please try again."
                    }
                    showAlert = true
                }
            }
        } else {
            alertTitle = "Biometric authentication not available"
            alertMessage = "Biometric authentication not available to be completed successfully."
            showAlert = true
            self.authError = error?.localizedDescription ?? "Biometric authentication not available"
        }
    }
}
