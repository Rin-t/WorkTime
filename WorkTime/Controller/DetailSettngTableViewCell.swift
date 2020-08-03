//
//  DetailSettngTableViewCell.swift
//  WorkTime
//
//  Created by Rin on 2020/07/29.
//  Copyright © 2020 竹村凜. All rights reserved.
//

import UIKit

class DetailSettngTableViewCell: UITableViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    func setCell(title: String, time: String) {
        titleLabel.text = title
        timeLabel.text = time
      }
    
    

}
