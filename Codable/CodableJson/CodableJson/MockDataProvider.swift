//
//  MockDataProvider.swift
//  CodableJson
//
//  Created by ZippiCoder on 12/11/17.
//  Copyright © 2017 ZippiCoder. All rights reserved.
//

import Foundation

struct MockDataProvider {
    
    /// Creates array of Json objects which corresponds to `Writer` model
    ///
    /// - Parameter count: count of objects in array
    /// - Returns: `Data` representation of JSON objects
    func createJson(items count: Int) -> Data? {
        var array: [[String: Any]] = []
        
        for i in 0...count {
            let dict = ["name": "\(i)",
                "email": "\(i)",
                "contact": "\(i)",
                "years":  "11",
                "isPublic": true] as [String : Any]
            
            array.append(dict)
        }
        
        return try? jsonData(from: array)
    }
    
    /// Creates array of Json objects which corresponds to `ComplexWriterCodable` model
    ///
    /// - Parameter count: count of objects in array
    /// - Returns: `Data` representation of JSON objects
    func createComplexJson(items count: Int) -> Data? {
        var array: [[String: Any]] = []
        
        let booksCount = 10
        for i in 0...count {
            var books: [[String: Any]] = []
            
            // generate books array
            for i in 0...booksCount {
                let book = [
                    "title": "\(i)",
                    "series": "\(i)",
                    "genre": "\(i)",
                    "published": Date().timeIntervalSince1970,
                    "translatedLanguages": ["\(i)"],
                    "adaptations": ["\(i)"]
                    
                    ] as [String : Any]
                books.append(book)
            }
            
            
            let author = [
                "name": "\(i)",
                "email": "\(i)",
                "contact": "\(i)",
                "isPublic": true,
                "bornDate": Date().timeIntervalSince1970,
                "diedDate": Date().timeIntervalSince1970,
                "occupation": "\(i)",
                "nationality": "\(i)",
                "citizenship": "\(i)",
                "genre": ["\(i)"],
                "chirdren": 4,
                "notableWorks": ["\(i)", "\(i)", "\(i)"],
                "allWorks": books,
                
                ] as [String : Any]
            
            array.append(author)
        }
        
        return try? jsonData(from: array)
    }

    
    // MARK: - Data Generation
    func jsonData(from array:[[String: Any]] ) throws -> Data {
        let jsonData = try JSONSerialization.data(withJSONObject: array, options: JSONSerialization.WritingOptions.prettyPrinted)
        return jsonData
    }
}
