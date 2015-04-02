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

class AlarmListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var alarms: AlarmContainer?
    var currentIndexPath: NSIndexPath?
    
    @IBAction func unwindAddEdit(segue: UIStoryboardSegue) {
        let source: AlarmAddEditViewController = segue.sourceViewController as AlarmAddEditViewController
        self.alarms![self.currentIndexPath!.row] = source.alarm!
        self.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let manager = Alamofire.Manager(configuration: nil)
        manager.request(.GET, "http://private-06e74-cloudalarm.apiary-mock.com/alarms").responseJSON() {
            (request, response, JSON , error) in
            if let JSON: AnyObject = JSON {
                self.alarms =  Mapper<AlarmContainer>().map(JSON as [String : AnyObject])
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showEditAlarm" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                self.currentIndexPath = indexPath
                
                let alarm = self.alarms![indexPath.row]
                let destination: AlarmAddEditViewController = segue.destinationViewController as AlarmAddEditViewController
                destination.alarm = alarm
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let alarms = self.alarms {
            return alarms.count
        } else {
            return 0
        }
    }

    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            self.alarms!.remove(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
        }
    }

   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      //  let cell = tableView.dequeueReusableCellWithIdentifier("AlarmCell", forIndexPath: indexPath) as UITableViewCell
       // cell.textLabel!.text = self.alarms!.alarms![indexPath.row].title
        let cell: AlarmTableViewCell = tableView.dequeueReusableCellWithIdentifier("AlarmCell",  forIndexPath: indexPath) as AlarmTableViewCell
    var daysLabelText:String = ""
    
    var count = self.alarms![indexPath.row].days!.count
    
    var daysArray = self.alarms![indexPath.row].days! as Array
    if count > 0 {
        
        var lowestValue = daysArray[0]
        
        for  element in 0...count-1 {
            if daysArray[element] == 0 {
                daysLabelText += "Mon "
            }
            
            if daysArray[element] == 1 {
                daysLabelText += "Tue "
            }
            
            if daysArray[element] == 2 {
                daysLabelText += "Wed "
            }
            
            if daysArray[element] == 3 {
                daysLabelText += "Thu "
            }
            if daysArray[element] == 4 {
                daysLabelText += "Fri "
            }
            
            if daysArray[element] == 5 {
                daysLabelText += "Sat "
            }
            
            if daysArray[element] == 6 {
                daysLabelText += "Sun"
            }
        }
    }
    
    if count == 2
    {
        //println(self.alarms![indexPath.row].days![0])
        if (daysArray[0] == 5 && daysArray[1] == 6) {
            daysLabelText = "Weekends"
        }
    }
    
    if count == 5
    {
        //println(self.alarms![indexPath.row].days![0])
        if (daysArray[0] == 0 && daysArray[1] == 1 && daysArray[2] == 2 && daysArray[3] == 3 && daysArray[4] == 4 && daysArray[5] == 5) {
            daysLabelText = "Work days"
        }
    }
    
    if count == 7
    {
        daysLabelText = "Every day"
    }
    
    if daysLabelText == "" {
        daysLabelText = "No repeat"
    }

    
    
    
    
    cell.setCell(self.alarms![indexPath.row].title!,hours: String(self.alarms![indexPath.row].hour!),minutes: String(self.alarms![indexPath.row].minute!), days: daysLabelText)
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

