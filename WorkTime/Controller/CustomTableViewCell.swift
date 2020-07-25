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
    @IBOutlet weak var workTimeLabel: UILabel!
    @IBOutlet weak var oneTimeInputLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(date: String, beginningTime: String, finishTime: String, breakTime: String) {
        dateLabel.text = date + "日"
        beginingTimeLabel.text = beginningTime
        finishTimeLabel.text = finishTime
        breakTimeLabel.text = breakTime
    }

}
