//
//  CustomButton.swift
//  Word2Vec4Kids
//
//  Created by Yash Verma on 3/5/24.
//

import Foundation
import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .padding()
            .foregroundColor(.white)
            .frame(minWidth: 0, maxWidth: 400)
            .background(
                RoundedRectangle(cornerRadius: 100)
                    .fill(glassyGradient())
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0) // Apply scale effect only when pressed
            .animation(.easeInOut(duration: 0.5)) // Add animation
    }
    
    private func glassyGradient() -> LinearGradient {
        return LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 0.5, green: 0.8, blue: 1.0), // Lighter shade of your existing color
                Color(red: 0, green: 0.6, blue: 0.8) // Your existing color
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

struct CustomButton: View {
    let action: () -> Void
    let label: () -> Text // Update label type to Text
    
    var body: some View {
        Button(action: action) {
            label()
        }
        .buttonStyle(CustomButtonStyle()) // Apply custom button style
        .padding(.horizontal) // Add horizontal padding
        .frame(height: 60)
    }
}
