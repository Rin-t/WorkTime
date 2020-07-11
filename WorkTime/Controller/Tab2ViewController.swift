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
    
    var data: [[String]] = []
    var beginningTimesData: [String] = []
    var finishTimesData: [String] = []
    var biginningDayData: [String] = []
    var finishDayData: [String] = []
    var breakTimeData: [String] = []
    var breakDayData: [String] = []
    
    var year = 0
    var month = 0
    var days = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 1...31{
            data.append([String(i),"","",""])
        }
        
        timerUpdate()
        tableView.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let biginingTimes = UserDefaults.standard.array(forKey: "beginningTime") as? [String] else {
            return
        }
        self.beginningTimesData = biginingTimes
        
        guard let finishTimes = UserDefaults.standard.array(forKey: "finishTime") as? [String] else {
            return
        }
        self.finishTimesData = finishTimes
        
        guard let biginningDay = UserDefaults.standard.array(forKey: "beginningDay") as? [String] else {
            return
        }
        self.biginningDayData = biginningDay
        
        guard let finishDay = UserDefaults.standard.array(forKey: "finishDay") as? [String] else {
            return
        }
        self.finishDayData = finishDay
        
        guard let breakTime = UserDefaults.standard.array(forKey: "breakTime") as? [String] else {
            return
        }
        self.breakTimeData = breakTime
        
        guard let breakDay = UserDefaults.standard.array(forKey: "breakDay") as? [String] else {
            return
        }
        self.breakDayData = breakDay
        
        for i in 0...biginningDay.count - 1 {
            if biginningDayData[i] == "01" || biginningDayData[i] == "02" || biginningDayData[i] == "03" || biginningDayData[i] == "04" || biginningDayData[i] == "05" || biginningDayData[i] == "06" || biginningDayData[i] == "07" || biginningDayData[i] == "08" || biginningDayData[i] == "09" {
                biginningDayData[i] = String(biginningDayData[i].dropFirst(1))
            }
            for j in 0...30 {
                if biginningDayData[i] == data[j][0] {
                    data[j][1] = beginningTimesData[i]
                }
            }
        }
        
        for i in 0...finishDay.count - 1 {
            if finishDayData[i] == "01" || finishDayData[i] == "02" || finishDayData[i] == "03" || finishDayData[i] == "04" || finishDayData[i] == "05" || finishDayData[i] == "06" || finishDayData[i] == "07" || finishDayData[i] == "08" || finishDayData[i] == "09" {
                finishDayData[i] = String(finishDayData[i].dropFirst(1))
            }
            for j in 0...30 {
                if finishDayData[i] == data[j][0] {
                    data[j][2] = finishTimesData[i]
                }
            }
        }
        
        for i in 0...breakDayData.count - 1 {
            if breakDayData[i] == "01" || breakDayData[i] == "02" || breakDayData[i] == "03" || breakDayData[i] == "04" || breakDayData[i] == "05" || breakDayData[i] == "06" || breakDayData[i] == "07" || breakDayData[i] == "08" || breakDayData[i] == "09" {
                breakDayData[i] = String(breakDayData[i].dropFirst(1))
            }
            for j in 0...30 {
                if breakDayData[i] == data[j][0] {
                    data[j][3] = breakTimeData[i]
                }
            }
        }
        print(data)
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
    
    //MARK: - timerUpdate
    
    
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
  
        cell.setCell(date: data[indexPath.row][0] , beginningTime: data[indexPath.row][1] , finishTime: data[indexPath.row][2], breakTime: data[indexPath.row][3] )
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDayDetail", sender: nil)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        <#code#>
//    }
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
