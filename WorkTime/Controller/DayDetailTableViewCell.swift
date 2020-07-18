//
//  DayDetailTableViewCell.swift
//  WorkTime
//
//  Created by Rin on 2020/07/18.
//  Copyright © 2020 竹村凜. All rights reserved.
//

import UIKit

class DayDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(title: String, time: String) {
        titleLabel.text = title
        timeLabel.text = time
    }
}
