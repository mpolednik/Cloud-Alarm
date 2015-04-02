//
//  AlarmAddEditTableViewController.swift
//  Cloud Alarm
//
//  Created by Martin Polednik on 4/2/15.
//  Copyright (c) 2015 FI MU. All rights reserved.
//

import UIKit

class AlarmAddEditTableViewController: UITableViewController {
    
    var selectedDays: [Int] = []
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showRepeatPicker" {
            let destination: RepeatPickerViewController = segue.destinationViewController as RepeatPickerViewController
            destination.selectedDays = self.selectedDays
        }
    }
}