//
//  User.swift
//  iBeacon System
//
//  Created by Ellan Esenaliev on 3/31/20.
//  Copyright © 2020 Anastasiya Ussenko. All rights reserved.
//

import Foundation
import ObjectMapper

struct User: Mappable {
    
    var id: String = ""
    var isAdmin: Bool = false
    var beacon: [Beacon] = []
    var rooms: [Room] = []
    var email: String = ""
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        isAdmin <- map["isAdmin"]
        beacon <- map["beacon"]
        rooms <- map["rooms"]
        email <- map["email"]
    }
}
