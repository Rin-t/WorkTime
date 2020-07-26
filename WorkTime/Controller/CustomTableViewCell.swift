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
    
    @IBAction func bulkInputTapped(_ sender: UIButton) {
     
        
        guard var data = UserDefaults.standard.object(forKey: "data") as? [[String: String]] else {
            return
        }
        
        let todayData = data.filter { data -> Bool in
            data["年"] == ymd.year && data["月"] == ymd.month && data["日"] == ymd.day
        }
        
        if todayData == [] {
            beginingTimeLabel.text = "9:00"
            finishTimeLabel.text = "17:00"
            breakTimeLabel.text = "60"
            data.append(["年": String(ymd.year), "月": String(ymd.month), "日": String(ymd.day), "出勤": "9:00", "退勤": "17:00", "休憩": "60", "memo": ""])
        } else if todayData != [] {
            print("dataあるよ")
        }
        UserDefaults.standard.set(data, forKey: "data")
        print(data)
        
    }
    

}
