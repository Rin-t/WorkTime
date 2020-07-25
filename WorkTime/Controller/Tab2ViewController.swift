//
//  Tab2ViewController.swift
//  WorkTime
//
//  Created by Rin on 2020/06/27.
//  Copyright © 2020 竹村凜. All rights reserved.
//

import UIKit


struct WorkStatus {
    var year: String
    let month: String
    let day: String
}


class Tab2ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    // userdefaultData か data に揃えた方が良さそう
    var userdefaultData: [[String: String]] = []
    var data: [[String: String]] = []
    var data2: [WorkStatus] = []
    
    var year = 0
    var month = 0
    var days = 0
    var passYmd: WorkStatus!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerUpdate()
        
        for i in 1...31{
            data.append(["年": String(year), "月":String(month), "日": "\(String(i))", "出勤": "", "退勤":"", "休憩": "", "memo": ""])
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let data = UserDefaults.standard.object(forKey: "data") as? [[String: String]] else {
            return
        }
        
        for dayData in data {
            let year = dayData["年"]!
            let month = dayData["月"]!
            let day = dayData["日"]!
            let workStatus2 = WorkStatus(year: year, month: month, day: day)
            data2.append(workStatus2)
        }
        
        
        let julyData = data2.filter { workStatus2 -> Bool in
            workStatus2.month == "07"
        }

        self.userdefaultData = data
        
        if userdefaultData.count == 0 {
            return
        } else {
            for i in 0...userdefaultData.count - 1 {
                for j in 0...30{
                    if Int(userdefaultData[i]["日"]!) == Int(self.data[j]["日"]!) && userdefaultData[i]["年"] == self.data[j]["年"] && Int(userdefaultData[i]["月"]!) == Int(self.data[j]["月"]!) {
                        self.data[j] = userdefaultData[i]
                        
                    }
                }
            }
            
            tableView.reloadData()
            
        }
        
    }
    
    
    
    
    
    //MARK: - Next,PreviousMonthButton
    @IBAction func nextMonthTapped(_ sender: UIButton) {
        
        //その年月のデータのみ取得してdataに入れる
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
    
    //MARK: - timerUpdate
    
    
    func timerUpdate() {
        
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

//MARK: - TableView

extension Tab2ViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if month == 01 || month == 03 || month == 05 || month == 07 || month == 08 || month == 10 || month == 12 {
            days = 31
        } else if month == 04 || month == 06 || month == 09 || month == 11 {
            days = 30
        } else if year % 4 == 0 && month == 02 {
            days = 29
        } else {
            days = 28
        }
        return days
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "time")! as! CustomTableViewCell
        cell.setCell(date: data[indexPath.row]["日"]!, beginningTime: data[indexPath.row]["出勤"]!, finishTime:data[indexPath.row]["退勤"]! , breakTime: data[indexPath.row]["休憩"]!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let passData = WorkStatus(year: String(year), month: String(month), day: data[indexPath.row]["日"]!)
        print(passData)
        passYmd = passData
        performSegue(withIdentifier: "goToDayDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! DayDetailViewController
        nextVC.ymd = passYmd
    }
    
    
}
