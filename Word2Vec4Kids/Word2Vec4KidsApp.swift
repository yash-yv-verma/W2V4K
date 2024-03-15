//
//  Word2Vec4KidsApp.swift
//  Word2Vec4Kids
//
//  Created by Yash Verma on 3/2/24.
//

import SwiftUI

@main
struct Word2Vec4KidsApp: App {
    @State private var isAuthenticated = false // Track authentication state
    
    var body: some Scene {
        WindowGroup {
            if isAuthenticated {
                ContentView()
            } else {
                WelcomeView()
            }
        }
    }
}
