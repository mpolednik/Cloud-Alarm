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
    var tableViewController: AlarmAddEditTableViewController?
    var selectedDays: [Int] = [] {
        didSet {
            tableViewController!.selectedDays = selectedDays
        }
    }
    
    @IBOutlet weak var timepicker: UIDatePicker!
    
    @IBAction func unwindRepeat(segue: UIStoryboardSegue) {
        let controller: RepeatPickerViewController = segue.sourceViewController as RepeatPickerViewController
        self.selectedDays = controller.selectedDays
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
            
            if let repeat = alarm.days {
                self.selectedDays = repeat
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

class AlarmAddEditTableViewController: UITableViewController {
    
    var selectedDays: [Int] = []
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showRepeatPicker" {
            let destination: RepeatPickerViewController = segue.destinationViewController as RepeatPickerViewController
            destination.selectedDays = self.selectedDays
        }
    }
}