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
    var alarms: AlarmContainer? = nil

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
                let object = self.alarms!.alarms![indexPath.row]
                (segue.destinationViewController as AlarmAddEditViewController).alarm = object
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let alarms = self.alarms {
            return alarms.alarms!.count
        } else {
            return 0
        }
    }

    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            self.alarms!.alarms?.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
        }
    }

   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      //  let cell = tableView.dequeueReusableCellWithIdentifier("AlarmCell", forIndexPath: indexPath) as UITableViewCell
       // cell.textLabel!.text = self.alarms!.alarms![indexPath.row].title
        let cell: AlarmTableViewCell = tableView.dequeueReusableCellWithIdentifier("AlarmCell",  forIndexPath: indexPath) as AlarmTableViewCell
        cell.setCell(self.alarms!.alarms![indexPath.row].title!,hours: String(self.alarms!.alarms![indexPath.row].hour!),minutes: String(self.alarms!.alarms![indexPath.row].minute!))
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

