//
//  AlarmsTableViewCell.swift
//  Cloud Alarm
//
//  Created by Michal Šimík on 31.03.15.
//  Copyright (c) 2015 FI MU. All rights reserved.
//

import UIKit

class AlarmTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var leftLabelText: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var minutesLabel: UILabel!
    
    
    override func awakeFromNib() {
         super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(leftLabelText: String, hours: String, minutes: String){
        self.leftLabelText.text = leftLabelText
        self.hoursLabel.text = hours
        self.minutesLabel.text = minutes
        
    }
}
