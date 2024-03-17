//
//  MadLibsView.swift
//  Word2Vec4Kids
//
//  Created by Yash Verma on 3/17/24.
//

import SwiftUI

struct MadLibsView: View {
    @State private var userInput = "" // Shared user input for all mad libs
    @State private var currentSetIndex = 0 // Index to track the current set of questions
    
    let madLibsSets = [
        ["The boy _____s ice cream.", "I _____ to live in the library.", "You can't always get what you ____."],
        ["She ____ her way into the party.", "I ____ my way into the place.", "He ____ his way into the train."],
        ["The cat _____ a poisionus disease.", "The boy _____ a drink.", "The school _____ a library."]
    ]
    
    var currentSet: [String] {
        madLibsSets[currentSetIndex]
    }
    
    var body: some View {
        ZStack {
            Image("backgroundImage") // Use the backgroundImage as the background
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                ForEach(0..<currentSet.count, id: \.self) { index in
                    MadLibsSentenceView(sentence: currentSet[index], userInput: $userInput)
                        .padding(.horizontal, 30)
                }
                
                Spacer()
                
                Button("Enter") {
                    currentSetIndex = (currentSetIndex + 1) % madLibsSets.count // Load the next set of mad libs
                    userInput = "" // Clear user input for the new set
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(8)
                .padding(.horizontal, 30)
            }
            .padding(.horizontal, 20)
        }
    }
}

struct MadLibsSentenceView: View {
    let sentence: String
    @Binding var userInput: String

    var body: some View {
        HStack {
            Text(sentence)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.blue)
                .padding(.horizontal, 20)
            
            TextField("Your answer", text: $userInput)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .foregroundColor(Color.blue)
                .padding(.horizontal)
        }
        .padding(.vertical, 10) // Add spacing from the screen edges
        .padding(.horizontal, 20)
    }
}
