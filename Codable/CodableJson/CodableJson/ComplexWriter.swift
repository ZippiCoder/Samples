//
//  ComplexWriterModel.swift
//  CodableJson
//
//  Created by ZippiCoder on 12/3/17.
//  Copyright © 2017 ZippiCoder. All rights reserved.
//

import Foundation

struct ComplexWriter {
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

struct Book {
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

extension Book: Decodable {
    enum CodingKeys: String, CodingKey {
        case title
        case series
        case genre
        case published
        case translatedLanguages
        case adaptations
    }
    
    init(from decoder: Decoder) throws {
        let values      = try decoder.container(keyedBy: CodingKeys.self)
        title           = try? values.decode(String.self, forKey: .title)
        series          = try? values.decode(String.self, forKey: .series)
        genre           = try? values.decode(String.self, forKey: .genre)
        published       = try? values.decode(Double.self, forKey: .published)
        translatedLanguages    = try? values.decode([String].self, forKey: .translatedLanguages)
        adaptations     = try? values.decode([String].self, forKey: .adaptations)
    }
}

// Uncomment for Decode with `init(from decoder: Decoder)`
//extension ComplexWriter: Decodable {
//    enum CodingKeys: String, CodingKey {
//        case name
//        case email
//        case contact
//        case isPublic
//        case bornDate
//        case diedDate
//        case occupation
//        case nationality
//        case citizenship
//        case genre
//        case chirdren
//        case notableWorks
//        case allWorks
//    }
//
//
//    init(from decoder: Decoder) throws {
//        let values       = try decoder.container(keyedBy: CodingKeys.self)
//        name             = try? values.decode(String.self, forKey: .name)
//        email            = try? values.decode(String.self, forKey: .email)
//        contact          = try? values.decode(String.self, forKey: .contact)
//        isPublic         = try? values.decode(Bool.self, forKey: .isPublic)
//        bornDate         = try? values.decode(Double.self, forKey: .bornDate)
//        diedDate         = try? values.decode(Double.self, forKey: .diedDate)
//        occupation       = try? values.decode(String.self, forKey: .occupation)
//        nationality      = try? values.decode(String.self, forKey: .nationality)
//        citizenship      = try? values.decode(String.self, forKey: .citizenship)
//        genre            = try? values.decode([String].self, forKey: .genre)
//        chirdren         = try? values.decode(Int.self, forKey: .chirdren)
//        notableWorks     = try? values.decode([String].self, forKey: .notableWorks)
//        allWorks         = try? values.decode([Book].self, forKey: .allWorks)
//    }
//}

