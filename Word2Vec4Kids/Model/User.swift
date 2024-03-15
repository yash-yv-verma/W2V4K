//
//  User.swift
//  Word2Vec4Kids
//
//  Created by Yash Verma on 3/14/24.
//

import Foundation

struct User: Identifiable {
    var id = UUID()
    var name: String
    var initial: Character
    var gradeLevel: Int
    
    init(name: String, initial: Character, gradeLevel: Int) {
        self.name = name
        self.initial = initial
        self.gradeLevel = gradeLevel
    }
}
