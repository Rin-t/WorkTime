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
    
    var userdefaultData: [[String: String]] = []
    var data: [[String: String]] = []
    var year = 0
    var month = 0
    var days = 0
    @IBOutlet weak var tabbaritem: UITabBarItem!
    var passYmd: WorkStatus!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerUpdate()
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        timerUpdate()
        data.removeAll()
        for i in 1...31 {
            data.append(["年": String(year), "月": String(month), "日": "\(String(i))", "出勤": "", "退勤": "", "休憩": "", "memo": ""])
        }
        guard var dataList = UserDefaults.standard.object(forKey: "data") as? [[String: String]] else {
            return
        }
        dataList = dataList.filter { (data) -> Bool in
            Int(data["月"]!)! ==  month
        }
        
        if dataList.count == 0 {
            return
        } else {
            for i in 0...dataList.count - 1 {
                for j in 0...30 {
                    if dataList[i]["日"] == data[j]["日"] && dataList[i]["年"] == data[j]["年"] && dataList[i]["月"] == data[j]["月"] {
                        data[j] = dataList[i]
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
        
        data.removeAll()
        for i in 1...31 {
            data.append(["年": String(year), "月": String(month), "日": "\(String(i))", "出勤": "", "退勤": "", "休憩": "", "memo": ""])
        }
        print(data)
        guard var dataList = UserDefaults.standard.object(forKey: "data") as? [[String: String]] else {
            return
        }
        
        dataList = dataList.filter { (data) -> Bool in
            data["月"] ==  String(month)
        }
        
        print("aaaaaaaaaaaaaaaaa")
        
        print(dataList)
        
        if dataList.count == 0 {
            
        } else {
            for i in 0...dataList.count - 1 {
                for j in 0...30 {
                    if Int(dataList[i]["日"]!) == Int(data[j]["日"]!) && dataList[i]["年"] == data[j]["年"] && Int(dataList[i]["月"]!) == Int(data[j]["月"]!) {
                        data[j] = dataList[i]
                        data[j]["日"] = String(j + 1)
                        
                    }
                }
            }
        }
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
        data.removeAll()
        for i in 1...31 {
            data.append(["年": String(year), "月": String(month), "日": "\(String(i))", "出勤": "", "退勤": "", "休憩": "", "memo": ""])
        }
        print(data)
        guard var dataList = UserDefaults.standard.object(forKey: "data") as? [[String: String]] else {
            return
        }
        
        dataList = dataList.filter { (data) -> Bool in
            data["月"] ==  String(month)
        }
        
        print(dataList)
        
        if dataList.count == 0 {
            
        } else {
            for i in 0...dataList.count - 1 {
                for j in 0...30 {
                    if Int(dataList[i]["日"]!) == Int(data[j]["日"]!) && dataList[i]["年"] == data[j]["年"] && Int(dataList[i]["月"]!) == Int(data[j]["月"]!) {
                        data[j] = dataList[i]
                        data[j]["日"] = String(j + 1)
                        
                    }
                }
            }
            
        }
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
    
    @objc func showAlert(sender: UIButton, cell: CustomTableViewCell) {
        let alert = UIAlertController(title: "一括保存の確認", message: "すでにデータがある場合上書きされます。\n一括入力しますか？", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "する", style: .default) { (UIaleratAction) in
            print(sender.tag)
            let defaultTime = UserDefaults.standard.object(forKey: "defaultTime") as? [String]
            self.data[sender.tag]["年"] = String(self.year)
            self.data[sender.tag]["月"] = String(self.month)
            self.data[sender.tag]["出勤"] = defaultTime![0]
            self.data[sender.tag]["退勤"] = defaultTime![1]
            self.data[sender.tag]["休憩"] = defaultTime![2]
            
            guard var dataList = UserDefaults.standard.object(forKey: "data") as? [[String: String]] else {
                return
            }
            dataList.append(["年":String(self.year), "月":String(self.month), "日": String(sender.tag + 1), "出勤":defaultTime![0], "退勤":defaultTime![1], "休憩": defaultTime![2]])
            
            UserDefaults.standard.set(dataList, forKey: "data")
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "しない", style: .default, handler: nil)
        
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        
        
    }
    
}

//MARK: - TableView

extension Tab2ViewController: UITableViewDataSource, UITableViewDelegate {
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
        cell.setCell(date: data[indexPath.row]["日"]!, beginningTime: data[indexPath.row]["出勤"]!, finishTime: data[indexPath.row]["退勤"]!, breakTime: data[indexPath.row]["休憩"]!)
        
        cell.bulkInputButton.tag = indexPath.row
        cell.bulkInputButton.addTarget(self, action: #selector(Tab2ViewController.showAlert(sender:cell:)), for: .touchUpInside)
        cell.ymd = WorkStatus(year: data[indexPath.row]["年"]!, month: data[indexPath.row]["月"]!, day: data[indexPath.row]["日"]!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let passData = WorkStatus(year: String(year), month: String(month), day: data[indexPath.row]["日"]!)
        passYmd = passData
        performSegue(withIdentifier: "goToDayDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! DayDetailViewController
        nextVC.ymd = passYmd
    }
    
}
