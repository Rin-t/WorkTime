//
//  Tab2ViewController.swift
//  WorkTime
//
//  Created by Rin on 2020/06/27.
//  Copyright © 2020 竹村凜. All rights reserved.
//

import UIKit

class Tab2ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    var data: [String] = []
    var year = 0
    var month = 0
    var days = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timerUpdate()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let data = UserDefaults.standard.array(forKey: "data") as? [String] else {
            return
        }
        self.data = data.sorted().reversed()
        tableView.reloadData()
    }
    
    
    
    
    
//MARK: - Next,PreviousMonthButton
    @IBAction func nextMonthTapped(_ sender: UIButton) {
        if month == 12 {
            month = 1
            year += 1
        } else {
            month += 1
        }
        monthLabel.text = String(month)  + "月"
        yearLabel.text = String(year)  + "年"
        tableView.reloadData()
        
    }
    
    
    @IBAction func previousMonthTapped(_ sender: UIButton) {
        if month == 1 {
            month = 12
            year -= 1
        } else {
            month -= 1
        }
        monthLabel.text = String(month)  + "月"
        yearLabel.text = String(year)  + "年"
        tableView.reloadData()
        
    }
    
    //MARK: - TableView
    
    
    @objc func timerUpdate() {
      
        let date = DateFormatter()
        date.timeStyle = .none
        date.dateStyle = .short
        date.locale = Locale(identifier: "ja_JP")
        let today = Date()
        let dateString = date.string(from: today)
        
        month = Int(dateString.dropFirst(5).dropLast(3))!
        year = Int(dateString.dropLast(6))!
        monthLabel.text = String(month)  + "月"
        yearLabel.text = String(year) + "年"
        
    }
   
    

}
 
extension Tab2ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return data.count
    }
        //        if month == 01 || month == 03 || month == 05 || month == 07 || month == 08 || month == 10 || month == 12 {
        //            days = 31
        //        } else if month == 04 || month == 06 || month == 09 || month == 11 {
        //            days = 30
        //        } else if year % 4 == 0 && month == 02 {
        //            days = 29
        //        } else {
        //            days = 28
        //        }
        //        return days
        //    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "time", for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "time")! as UITableViewCell
            cell.textLabel?.text = data[indexPath.row]
//        cell.textLabel!.text = String(indexPath.row + 1) + "日"

        return cell
    }
}

//extension Tab2ViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return data.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(UITableViewCell.self))! as UITableViewCell
//        cell.textLabel?.text = data[indexPath.row]
//        return cell
//    }
//}
