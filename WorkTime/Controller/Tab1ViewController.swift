//
//  Tab1ViewController.swift
//  WorkTime
//
//  Created by Rin on 2020/06/25.
//  Copyright © 2020 竹村凜. All rights reserved.
//

import UIKit

class Tab1ViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var beginButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var breakButton: UIButton!
    var breakTime = "60"
    var data: [[String: String]] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let beginConvert = CreateCircle(button: beginButton)
        let finishConvert = CreateCircle(button: finishButton)
        let breakConvert = CreateCircle(button: breakButton)
        
        beginConvert.conversion()
        finishConvert.conversion()
        breakConvert.conversion()
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Tab1ViewController.timerUpdate), userInfo: nil, repeats: true)
        
        if let savedData = UserDefaults.standard.object(forKey: "data") as? Array<[String: String]> {
            data = savedData
        }
        UserDefaults.standard.set(data, forKey: "data")
        
        
        
    }
    
    
    
    //MARK: - Timer
    @objc func timerUpdate() {
        let time = DateFormatter()
        time.timeStyle = .short
        time.dateStyle = .none
        time.locale = Locale(identifier: "ja_JP")
        let now = Date()
        timeLabel.text = time.string(from: now)
        timeLabel.textColor = .black
        
        let date = DateFormatter()
        date.timeStyle = .none
        date.dateStyle = .full
        date.locale = Locale(identifier: "ja_JP")
        let today = Date()
        dateLabel.text = date.string(from: today)
        dateLabel.textColor = .black
        
    }
    
    //MARK: - 出退勤ボタン
    
    @IBAction func beginButtonTapped(_ sender: UIButton) {
        getTime(buttonTitle: sender.currentTitle!)
       
        
    }
    
    @IBAction func finishButtonTapped(_ sender: UIButton) {
        getTime(buttonTitle: sender.currentTitle!)
        
        
    }
    
    @IBAction func breakButtonTapped(_ sender: UIButton) {
       getTime(buttonTitle: sender.currentTitle!)
        
        
    }
    
    
    
    func getTime(buttonTitle: String){
        let today = Date()
        
        //年月日のデータを取得
        let ymd = DateFormatter()
        ymd.timeStyle = .none
        ymd.dateStyle = .short
        ymd.locale = Locale(identifier: "ja_JP")
        
        let year = ymd.string(from: today).dropLast(6)
        let month = ymd.string(from: today).dropFirst(5).dropLast(3)
        let date = ymd.string(from: today).dropFirst(8)
        
        //時間データの取得
        let currentTime = DateFormatter()
        currentTime.timeStyle = .short
        currentTime.dateStyle = .none
        currentTime.locale = Locale(identifier: "ja_JP")
        
        let time = currentTime.string(from: today)
        
        //辞書型配列に取得データを追加
        
        guard var saveData = UserDefaults.standard.object(forKey: "data") as? Array<[String: String]> else {
            print("a")
            return
        }
        
         print(saveData)
        
        if saveData.count == 0 {
            if  buttonTitle == "休憩" {
                saveData.append(["年": "\(year)", "月":"\(month)", "日": "\(date)", "出勤": "", "退勤":"", "休憩": ""])
                saveData[0][buttonTitle] = breakTime
            } else {
                saveData.append(["年": "\(year)", "月":"\(month)", "日": "\(date)", "出勤": "", "退勤":"", "休憩": ""])
                saveData[0][buttonTitle] = String(time)
            }
            
        } else {
            
            for i in 0...saveData.count - 1{
                if saveData[i]["年"] == String(year) && saveData[i]["月"] == String(month) && saveData[i]["日"] == String(date){
                    if buttonTitle == "休憩" {
                        saveData[i][buttonTitle] = breakTime
                    } else {
                        saveData[i][buttonTitle] = String(time)
                    }
                } else if i == saveData.count - 1 {
                    if buttonTitle == "休憩" {
                        saveData[i][buttonTitle] = breakTime
                    } else {
                        saveData.append(["年": "\(year)", "月":"\(month)", "日": "\(date)", "出勤": "", "退勤":"", "休憩": ""])
                        saveData[i][buttonTitle] = String(time)
                    }
                    
                }
            }
            
        }
        UserDefaults.standard.set(saveData, forKey: "data")
        print(saveData)
        
        //Userdefault
       
        
//        guard var dateData = UserDefaults.standard.array(forKey: forKey) as? [String] else {
//            return
//        }
//        dateData.append(String(date.string(from: today).dropFirst(8)))
//        UserDefaults.standard.set(dateData, forKey: forKey)
//
//
//        let now = Date()
//
//        guard var timeData = UserDefaults.standard.array(forKey: forKey) as? [String] else {
//            return
//        }
//        timeData.append(time.string(from: now))
//        UserDefaults.standard.set(timeData, forKey: forKey)
        
        
        
        
        
        
        
        
    }

    

}



