//
//  WordArithmeticManager.swift
//  Word2Vec4Kids
//
//  Created by Yash Verma on 3/2/24.
//

import Foundation
import CustomWordEmbedding

struct WordArithmeticManager {
    static let shared = WordArithmeticManager()
    
    func performWordArithmetic(addends: [String], subtrahends: [String], numberOfKeys: Int, completion: @escaping ([String]) -> Void) {
        // Use SingletonEmbedding to set up the embedding and perform arithmetic
        SingletonEmbedding.shared.setup(filePath: "/Users/yshvrm/Documents/iOSProjects/glove/glove_100d_out.txt")
        
        // Get the embedding from SingletonEmbedding
        guard let embedding = SingletonEmbedding.shared.getEmbedding() else {
            print("Embedding not found")
            return
        }
        
        // Perform word arithmetic
        let combinedVec = embedding.getCombinedVec(adders: addends, subtractors: subtrahends) ?? []
        let vecs = embedding.findClosestVectorKeys(targetVector: combinedVec, numberOfKeys: numberOfKeys) ?? []
        
        for vec in vecs {
            print("\(vec)\n")
        }
        
        // Extract question and answer choices
        var result = [String]()
        var isFirst = true
        
        for vec in vecs {
            if isFirst {
                result.append(vec.key) // Add the first element as the question
                isFirst = false
            } else {
                result.append(vec.key) // Add the remaining elements as answer choices
            }
        }
        
        completion(result)
    }
}
