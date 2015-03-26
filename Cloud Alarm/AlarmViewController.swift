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

class AlarmViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    var alarm: Alarm? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AlarmCell", forIndexPath: indexPath) as UITableViewCell
        
        switch (indexPath.row) {
        case 0:
            cell.textLabel!.text = alarm!.title
        case 1:
            cell.textLabel!.text = alarm!.enabled!.description
        default:
            break
        }
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}