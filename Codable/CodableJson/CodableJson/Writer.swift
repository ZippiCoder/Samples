//
//  CodableUser.swift
//  CodableJson
//
//  Created by ZippiCoder on 12/3/17.
//  Copyright © 2017 ZippiCoder. All rights reserved.
//

import Foundation

struct Writer: Decodable {
    var name:       String?
    var email:      String?
    var contact:    String?
    var years:      Int?
    var isPublic:   Bool?
}

extension Writer {
    init(dictionary: [String : Any]) {
        name        = dictionary["name"] as? String
        email       = dictionary["email"] as? String
        contact     = dictionary["contact"] as? String
        years       = dictionary["years"] as? Int
        isPublic    = dictionary["isPublic"] as? Bool
    }
}

// Uncomment for Decode with `init(from decoder: Decoder)`
//extension Writer: Decodable {
//    enum CodingKeys: String, CodingKey {
//        case name
//        case email
//        case contact
//        case years
//        case isPublic
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        name        = try? values.decode(String.self, forKey: .name)
//        email       = try? values.decode(String.self, forKey: .email)
//        contact     = try? values.decode(String.self, forKey: .contact)
//        years       = try? values.decode(Int.self, forKey: .years)
//        isPublic    = try? values.decode(Bool.self, forKey: .isPublic)
//    }
//}

