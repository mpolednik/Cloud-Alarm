
//
//  Alarm.swift
//  Cloud Alarm
//
//  Created by Martin Polednik on 3/19/15.
//  Copyright (c) 2015 FI MU. All rights reserved.
//

import ObjectMapper

class Alarm: Mappable {
    var id: Int?
    var title: String?
    var hour: Int?
    var minute: Int?
    var enabled: Bool?
    var repeat: Bool?
    var days: [Int]?
    
    required init(_ map: Map) {
        mapping(map)
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        hour <- map["hour"]
        minute <- map["minute"]
        enabled <- map["enabled"]
        repeat <- map["repeat"]
        days <- map["days"]
    }
}