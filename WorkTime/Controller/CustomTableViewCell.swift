//
//  CustomTableViewCell.swift
//  WorkTime
//
//  Created by Rin on 2020/07/05.
//  Copyright © 2020 竹村凜. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var beginingTimeLabel: UILabel!
    @IBOutlet weak var finishTimeLabel: UILabel!
    @IBOutlet weak var breakTimeLabel: UILabel!
    @IBOutlet weak var bulkInputButton: UIButton!
    var ymd: WorkStatus!
    
    func setCell(date: String, beginningTime: String, finishTime: String, breakTime: String) {
        dateLabel.text = date + "日"
        beginingTimeLabel.text = beginningTime
        finishTimeLabel.text = finishTime
        breakTimeLabel.text = breakTime
    }
    
    
}
