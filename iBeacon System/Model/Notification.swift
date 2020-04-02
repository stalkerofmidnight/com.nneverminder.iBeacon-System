//
//  Notification.swift
//  iBeacon System
//
//  Created by Anastasiya Ussenko on 3/31/20.
//  Copyright © 2020 Anastasiya Ussenko. All rights reserved.
//

import Foundation
import ObjectMapper

struct Notification: Mappable {
    
    var id: String = ""
    var date: TimeInterval = 0.0
    var text: String = ""
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        date <- map["date"]
        text <- map["text"]
    }
    
    func getStringDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm, dd MMMM YYYY"
        return dateFormatter.string(from: Date(timeIntervalSince1970: date))
    }
}
