//
//  AlarmContainer.swift
//  Cloud Alarm
//
//  Created by Martin Polednik on 3/19/15.
//  Copyright (c) 2015 FI MU. All rights reserved.
//

import Foundation
import ObjectMapper

class AlarmContainer: Mappable {
    var alarms: [Alarm]?
    
    required init(_ map: Map) {
        mapping(map)
    }
    
    func mapping(map: Map) {
        alarms <- map["alarms"]
    }
}
