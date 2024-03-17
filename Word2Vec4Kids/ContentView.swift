//
//  ContentView.swift
//  Word2Vec4Kids
//
//  Created by Yash Verma on 3/2/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var question: QnA
    
    init() {
        _question = State(initialValue: QnA())
        let filePath = "/Users/yshvrm/Documents/iOSProjects/glove/glove_100d_out.txt"
        SingletonEmbedding.shared.setup(filePath: filePath)
    }
    
    @State private var pressedButton: Int?
    @State private var showMessage: Bool = false
    @State private var popupMessage: String = "" // Added popupMessage state
    
    @State private var showMadLibs: Bool = false // Track whether to show Mad Libs view
    
    var body: some View {
        ZStack {
            Image("backgroundImage") // Replace "backgroundImage" with the name of your image asset
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                QuestionView(question: question, pressedButton: $pressedButton, showMessage: $showMessage, popupMessage: $popupMessage)
                    .foregroundColor(Color(red: 0, green: 151/255, blue: 178/255))//Pass popupMessage
                
                Spacer()
                
                if showMessage, let pressedButton = pressedButton {
                    Text(popupMessage) // Display popupMessage
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(10)
                        .transition(.opacity)
                        .animation(.easeInOut(duration: 0.5))
                }
            }
            
            // Mad Libs Button
            Button(action: {
                showMadLibs.toggle()
            }) {
                Text("Mad-Libs")
                    .foregroundColor(.white)
                    .font(.title)
                    .padding()
            }
            .position(x: (NSScreen.main?.visibleFrame.width ?? 800) - 100, y: 40) // Position the button at the top right corner
            
            if showMadLibs {
                MadLibsView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity) // Cover the entire screen
                    .background(Color.white)
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Match the screen size
        .onAppear {
            // Call the word arithmetic function here
            WordArithmeticManager.shared.performWordArithmetic(addends: ["king", "woman"], subtrahends: ["man"], numberOfKeys: 5) { result in
                // Set the question and answer choices
                self.question = QnA(question: result[0], choice1: result[1], choice2: result[2], choice3: result[3], choice4: result[4], correctChoice: result[1]) // Assuming the correct choice is the second element
            }
        }
    }
}
