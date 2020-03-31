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
    var isProfessor: Bool = false
    var beacons: [Beacon] = []
    var rooms: [Room] = []
    var email: String = ""
    var name: String = ""
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        isProfessor <- map["isProfessor"]
        beacons <- map["beacons"]
        rooms <- map["rooms"]
        email <- map["email"]
        name <- map["name"]
    }
}
