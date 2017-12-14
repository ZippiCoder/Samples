//
//  CodableUser.swift
//  CodableJson
//
//  Created by ZippiCoder on 12/3/17.
//  Copyright © 2017 ZippiCoder. All rights reserved.
//

import Foundation

struct Writer: Codable {
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
