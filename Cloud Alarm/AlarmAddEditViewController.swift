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
    
    @IBOutlet weak var tableView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let alarm = alarm {
            println("edit")
        } else {
            println("add")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}