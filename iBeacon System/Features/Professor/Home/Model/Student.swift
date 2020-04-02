//
//  Student.swift
//  iBeacon System
//
//  Created by Anastasiya Ussenko on 3/31/20.
//  Copyright © 2020 Anastasiya Ussenko. All rights reserved.
//

import Foundation
import ObjectMapper

struct Student: Mappable {
    
    var id: String = ""
    var name: String = ""
    var email: String = ""
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
    }
}
