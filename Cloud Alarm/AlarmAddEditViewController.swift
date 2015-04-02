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
    
    @IBOutlet weak var timepicker: UIDatePicker!
    
    var alarm: Alarm? = nil
    var tableViewController: AlarmAddEditTableViewController?
    var selectedDays: [Int] = [] {
        didSet {
            if let tvc = tableViewController {
                tvc.selectedDays = selectedDays
            }
            if let alarm = alarm {
                alarm.days = selectedDays
            }
        }
    }
    
    @IBAction func unwindRepeat(segue: UIStoryboardSegue) {
        let source: RepeatPickerViewController = segue.sourceViewController as RepeatPickerViewController
        self.selectedDays = source.selectedDays
    }
    
    @IBAction func timepickerValueChanged(sender: AnyObject) {
        let time = timepicker.date
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: timepicker.date)
        
        if let alarm = self.alarm {
            alarm.minute = components.minute
            alarm.hour = components.hour
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "embededAlarmMenu" {
            let destination: AlarmAddEditTableViewController = segue.destinationViewController as AlarmAddEditTableViewController
            destination.selectedDays = self.selectedDays
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableViewController = childViewControllers[0] as? AlarmAddEditTableViewController
        if let alarm = self.alarm {
            // How do we set the timepicker hour and minute? Since constructing a NSDate object is quite difficult,
            // we can simply use current NSDate, create calendar based on that date and initiate it's components.
            // Having these, we can simply set relevant values and call dateFromComponents to actually setup the timepicker.
            let calendar = NSCalendar.currentCalendar()
            let components = calendar.components(nil, fromDate: NSDate())
            components.hour = alarm.hour!
            components.minute = alarm.minute!
            
            if let date = calendar.dateFromComponents(components) {
                self.timepicker.setDate(date, animated: true)
            }
            
            if let days = alarm.days {
                self.selectedDays = days
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}