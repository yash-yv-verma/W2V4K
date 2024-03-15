//
//  SingletonEmbedding.swift
//  testing_mac
//
//  Created by Nathan Wiatrek on 2/24/24.
//

import Foundation
import CustomWordEmbedding

class SingletonEmbedding {
    static let shared = SingletonEmbedding();
    private var embedding: CustomWordEmbedding?
    
    private init() {

    }
    
    func setup(filePath: String) {
//        let filePath = "/Users/nathan/Code/python/word2vec_test/combine_test/glove_100d_out.txt"
        print(filePath)
        do {
            let dictionary: [String:[Double]] = try readJSONFile(filePath: filePath)
            print("decoding done...")
            self.embedding = CustomWordEmbedding(dictionary: dictionary, dimensions: 100)
            print("class made...")
        } catch {
            print(error)
        }
        
    }
    func getEmbedding() -> CustomWordEmbedding? {
        return self.embedding
    }
    func readJSONFile(filePath: String) throws -> [String: [Double]] {
        let fileURL = URL(fileURLWithPath: filePath)
        
        // Use FileManager to check if the file exists
        if !FileManager.default.fileExists(atPath: filePath) {
            throw NSError(domain: "File not found", code: 404, userInfo: nil)
        }
        //print("HI1,.,.,.,.,.,.")
        // Read the file data
        let fileData = try Data(contentsOf: fileURL)
        //print("HI2,.,.,.,.,.,.")
        // Use JSONSerialization to parse the JSON data
        guard let jsonObject = try JSONSerialization.jsonObject(with: fileData, options: []) as? [String: [Double]] else {
            throw NSError(domain: "Invalid JSON format", code: 500, userInfo: nil)
        }
        //print("HI3,.,.,.,.,.,.")
        return jsonObject
    }


}
