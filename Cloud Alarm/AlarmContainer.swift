//
//  AlarmContainer.swift
//  Cloud Alarm
//
//  Created by Martin Polednik on 3/19/15.
//  Copyright (c) 2015 FI MU. All rights reserved.
//

import ObjectMapper

class AlarmContainer: Mappable {
    
    var alarms: [Alarm] = []
    var count: Int {
        get {
            return self.alarms.count
        }
    }
    
    required init(_ map: Map) {
        mapping(map)
    }
    
    func mapping(map: Map) {
        alarms <- map["alarms"]
    }
    
    subscript(index: Int) -> Alarm {
        get {
            return alarms[index]
        }
        set(newAlarm) {
            alarms[index] = newAlarm
        }
    }
    
    func remove(index: Int) {
        self.alarms.removeAtIndex(index)
    }
    
    func append(alarm: Alarm) {
        self.alarms.append(alarm);
    }
}
