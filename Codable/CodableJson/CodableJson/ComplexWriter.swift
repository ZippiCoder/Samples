//
//  ComplexWriterModel.swift
//  CodableJson
//
//  Created by ZippiCoder on 12/3/17.
//  Copyright © 2017 ZippiCoder. All rights reserved.
//

import Foundation

struct ComplexWriter: Codable {
    var name:           String?
    var email:          String?
    var contact:        String?
    var isPublic:       Bool?
    var bornDate:       Double?
    var diedDate:       Double?
    var occupation:     String?
    var nationality:    String?
    var citizenship:    String?
    var genre:          [String]?
    var chirdren:       Int?
    var notableWorks:   [String]?
    var allWorks:       [Book]?
}

struct Book: Codable {
    var title:          String?
    var series:         String?
    var genre:          String?
    var published:      Double?
    var translatedLanguages: [String]?
    var adaptations:    [String]?
}

extension ComplexWriter {
    init(dictionary: [String : Any]) {
        name        = dictionary["name"] as? String
        email       = dictionary["email"] as? String
        contact     = dictionary["contact"] as? String
        isPublic    = dictionary["isPublic"] as? Bool
        bornDate    = dictionary["bornDate"] as? Double
        diedDate    = dictionary["diedDate"] as? Double
        occupation  = dictionary["occupation"] as? String
        nationality = dictionary["nationality"] as? String
        citizenship = dictionary["citizenship"] as? String
        genre       = dictionary["genre"] as?  [String]
        chirdren    = dictionary["chirdren"] as?  Int
        notableWorks = dictionary["notableWorks"] as?  [String]
        
        if let works = dictionary["allWorks"] as? [[String: Any]] {
            allWorks = works.map({ Book(dictionary: $0) })
        }
    }
}

extension Book {
    init(dictionary: [String : Any]) {
        title        = dictionary["title"] as? String
        series       = dictionary["series"] as? String
        genre        = dictionary["genre"] as? String
        published    = dictionary["published"] as? Double
        translatedLanguages = dictionary["translatedLanguages"] as? [String]
        adaptations  = dictionary["adaptations"] as? [String]
    }
}
