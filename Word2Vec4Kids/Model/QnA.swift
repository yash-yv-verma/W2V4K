//
//  QnA.swift
//  Word2Vec4Kids
//
//  Created by Yash Verma on 3/2/24.
//

import Foundation

struct QnA: Identifiable {
    var id = UUID()
    var question: String
    var choice1: String
    var choice2: String
    var choice3: String
    var choice4: String
    let correctChoice: String
    
    var choices: [String] {
        return [choice1, choice2, choice3, choice4]
    }
    
    init(question: String = "", choice1: String = "", choice2: String = "", choice3: String = "", choice4: String = "", correctChoice: String = "") {
        self.question = question
        self.choice1 = choice1
        self.choice2 = choice2
        self.choice3 = choice3
        self.choice4 = choice4
        self.correctChoice = correctChoice
    }
}
