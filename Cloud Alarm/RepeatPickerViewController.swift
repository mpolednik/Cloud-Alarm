//
//  RepeatPickerViewController.swift
//  Cloud Alarm
//
//  Created by Martin Polednik on 4/2/15.
//  Copyright (c) 2015 FI MU. All rights reserved.
//

import Foundation
import UIKit

class RepeatPickerViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    let days: [String] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    var selectedDays: [Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for day in self.selectedDays {
            self.tableView.selectRowAtIndexPath(NSIndexPath(forRow: day, inSection: 0), animated: false, scrollPosition: .None)
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("RepeatCell") as UITableViewCell
        cell.textLabel!.text = days[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedDays.append(indexPath.row)
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        if let index = find(self.selectedDays, indexPath.row) {
            self.selectedDays.removeAtIndex(index)
        }
    }
}