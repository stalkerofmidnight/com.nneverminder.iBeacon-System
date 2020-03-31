//
//  Room.swift
//  iBeacon System
//
//  Created by Ellan Esenaliev on 3/31/20.
//  Copyright © 2020 Anastasiya Ussenko. All rights reserved.
//

import Foundation
import ObjectMapper

struct Room: Mappable {
   
    var users: [User] = []
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        users <- map["users"]
    }
}
