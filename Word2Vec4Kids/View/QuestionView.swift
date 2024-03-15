//
//  QuestionView.swift
//  Word2Vec4Kids
//
//  Created by Yash Verma on 3/2/24.
//

import Foundation
import SwiftUI

struct QuestionView: View {
    let question: QnA
    @Binding var pressedButton: Int?
    @Binding var showMessage: Bool
    @Binding var popupMessage: String
    
    var body: some View {
        VStack {
            Text((question.question).capitalized + "\t\t+\t\tWoman\t\t=\t\t________")
                .font(.largeTitle) // Example of changing font size
                .fontWeight(.bold) //  adding font weight
                .foregroundColor(Color(red: 0, green: 151/255, blue: 178/255))
                .padding()
            
            
            HStack {
                VStack(spacing: 20){
                    ForEach(question.choices.prefix(2), id: \.self) { choice in
                        CustomButton(action: {
                            self.pressedButton = question.choices.firstIndex(of: choice)! + 1
                            self.showMessage = true
                            // Update popupMessage immediately based on the selected choice
                            if choice == question.correctChoice {
                                self.popupMessage = "Correct! \(question.correctChoice) is the right answer."
                            } else {
                                self.popupMessage = "Incorrect! The correct answer is \(question.correctChoice)."
                            }
                            // Reset pressedButton and hide message after 2 seconds
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                self.showMessage = false
                                self.pressedButton = nil
                            }
                        }) {
                            Text(choice.capitalized)
                        }
                    }
                }
                .padding()
                
                VStack(spacing: 20) {
                    ForEach(question.choices.dropFirst(2), id: \.self) { choice in
                        CustomButton(action: {
                            self.pressedButton = question.choices.firstIndex(of: choice)! + 1
                            self.showMessage = true
                            // Update popupMessage immediately based on the selected choice
                            if choice == question.correctChoice {
                                self.popupMessage = "Correct! \(question.correctChoice) is the right answer."
                            } else {
                                self.popupMessage = "Incorrect! The correct answer is \(question.correctChoice)."
                            }
                            // Reset pressedButton and hide message after 2 seconds
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                self.showMessage = false
                                self.pressedButton = nil
                            }
                        }) {
                            Text(choice.capitalized)
                        }
                    }
                }
                .padding()
            }
        }
    }
}
