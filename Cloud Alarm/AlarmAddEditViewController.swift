//
//  AlarmViewController.swift
//  Cloud Alarm
//
//  Created by Martin Polednik on 3/26/15.
//  Copyright (c) 2015 FI MU. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class AlarmAddEditViewController: UIViewController {
    
    var alarm: Alarm? = nil
    
    @IBOutlet weak var timepicker: UIDatePicker!
    @IBOutlet weak var tableView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let alarm = alarm {
            // How do we set the timepicker hour and minute? Since constructing a NSDate object is quite difficult,
            // we can simply use current NSDate, create calendar based on that date and initiate it's components.
            // Having these, we can simply set relevant values and call dateFromComponents to actually setup the timepicker.
            let date = NSDate()
            let calendar = NSCalendar.currentCalendar()
            let components = calendar.components(nil, fromDate: date)
            components.hour = alarm.hour!
            components.minute = alarm.minute!
            if let newDate = calendar.dateFromComponents(components) {
                self.timepicker.setDate(newDate, animated: true)
            }
        } else {

        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}