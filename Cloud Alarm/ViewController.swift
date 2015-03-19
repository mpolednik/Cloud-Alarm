//
//  ViewController.swift
//  Cloud Alarm
//
//  Created by Martin Polednik on 3/13/15.
//  Copyright (c) 2015 FI MU. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let manager = Alamofire.Manager(configuration: nil)
        manager.request(.GET, "http://private-06e74-cloudalarm.apiary-mock.com/alarms").responseJSON() {
            (request, response, JSON , error) in
            if let JSON: AnyObject = JSON {
                let alarms =  Mapper<AlarmContainer>().map(JSON as [String : AnyObject])

                if let alarms = alarms.alarms {
                    for alarm in alarms {
                        println(alarm.id)
                        println(alarm.title)
                        println(alarm.hour)
                        println(alarm.minute)
                        println(alarm.enabled)
                        println(alarm.days)
                    }
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

