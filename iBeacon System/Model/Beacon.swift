//
//  Beacon.swift
//  iBeacon System
//
//  Created by Anastasiya Ussenko on 3/31/20.
//  Copyright © 2020 Anastasiya Ussenko. All rights reserved.
//

import Foundation
import ObjectMapper

struct Beacon: Mappable {
    
    var id: String = ""
    var uuid: String = ""
    var major: Int = 0
    var minor: Int = 0
    var professorID: String = ""
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        uuid <- map["uuid"]
        major <- map["major"]
        minor <- map["minor"]
        professorID <- map["professorID"]
    }
}
