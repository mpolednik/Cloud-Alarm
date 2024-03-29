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
    
    let BASE_URL: String = "http://localhost:3000/api"
    let AUTHORIZATION: String = "admin:admin"
    
    var alarms: AlarmContainer?
    var currentIndexPath: NSIndexPath?
    
    @IBAction func unwindAddEdit(segue: UIStoryboardSegue) {
        let source: AlarmAddEditViewController = segue.sourceViewController as AlarmAddEditViewController
        if source.edit {
            self.alarms![self.currentIndexPath!.row] = source.alarm!
        } else {
            self.alarms!.append(source.alarm!);
        }
        self.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        loadDataFromRealServer()
        loadDataFromMockServer()
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
    
    func loadDataFromMockServer() {
        Alamofire.Manager.sharedInstance.request(.GET, "http://private-06e74-cloudalarm.apiary-mock.com/alarms").responseJSON() {
            (request, response, JSON , error) in
            if let JSON: AnyObject = JSON {
                self.alarms =  Mapper<AlarmContainer>().map(JSON as [String : AnyObject])
                self.tableView.reloadData()
            }
        }
    }
    
    func loadDataFromRealServer() {
        let plainData = AUTHORIZATION.dataUsingEncoding(NSUTF8StringEncoding)
        let base64String = plainData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(0))
        
        var headers = Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders ?? [:]
        headers["Authorization"] = "Basic "+base64String
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.HTTPAdditionalHeaders = headers
        
        Alamofire
            .Manager(configuration: configuration)
            .request(.GET, BASE_URL+"/user")
            .responseJSON() {
                (request, response, JSON, error) in
                if let JSON: AnyObject = JSON {
                    let token : String = JSON["token"] as String
                    Alamofire
                        .Manager(configuration: nil)
                        .request(.GET, self.BASE_URL+"/alarms", parameters: ["access_token":token])
                        .responseJSON() {
                            (request2, response2, JSON2, error2) in
                            if let JSON2: AnyObject = JSON2 {
                                self.alarms =  Mapper<AlarmContainer>().map(JSON2 as [String : AnyObject])
                                self.tableView.reloadData()
                            }
                    }
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
    
    let wdays: [Int: String] = [0: "Mon ", 1: "Tue ", 2: "Wed ", 3: "Thu ", 4: "Fri ", 5: "Sat ", 6: "Sun "]
    
    var daysArray = sorted(self.alarms![indexPath.row].days!, {(e1: Int, e2: Int) -> Bool in e1 < e2}) as Array
    
    if count > 0 {
        for  element in 0...count-1 {
            daysLabelText += wdays[daysArray[element]]!
        }
    }
    
    if count == 2
    {
        if (daysArray[0] == 5 && daysArray[1] == 6) {
            daysLabelText = "Weekends"
        }
    }
    
    if count == 5
    {
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

