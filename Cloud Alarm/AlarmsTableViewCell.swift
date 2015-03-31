//
//  AlarmsTableViewCell.swift
//  Cloud Alarm
//
//  Created by Michal Šimík on 31.03.15.
//  Copyright (c) 2015 FI MU. All rights reserved.
//

import UIKit

class AlarmsTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var leftLabelText: UILabel!
    
    /*init(Style: UITableViewCellStyle, reuseIdentifier: String) {
        super.init(style: Style, reuseIdentifier: reuseIdentifier)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }*/
    
    override func awakeFromNib() {
         super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(leftLabelText: String){
        self.leftLabelText.text = leftLabelText
        
    }
}
