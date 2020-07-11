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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let beginConvert = CreateCircle(button: beginButton)
        let finishConvert = CreateCircle(button: finishButton)
        let breakConvert = CreateCircle(button: breakButton)
        
        beginConvert.conversion()
        finishConvert.conversion()
        breakConvert.conversion()
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Tab1ViewController.timerUpdate), userInfo: nil, repeats: true)
        
        //UserDefaults
        UserDefaults.standard.register(defaults: ["beginningTime" : []])
        UserDefaults.standard.register(defaults: ["beginningDay" : []])
        UserDefaults.standard.register(defaults: ["finishTime" : []])
        UserDefaults.standard.register(defaults: ["finishDay" : []])
        UserDefaults.standard.register(defaults: ["breakTime" : []])
        UserDefaults.standard.register(defaults: ["breakDay" : []])
        
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
        
        getTime(TimeForKey: "beginningTime",DayForKey: "beginningDay")
        
    }
    
    @IBAction func finishButtonTapped(_ sender: UIButton) {
        
        getTime(TimeForKey: "finishTime", DayForKey: "finishDay")
        
    }
    
    @IBAction func breakButtonTapped(_ sender: UIButton) {
        let date = DateFormatter()
        date.timeStyle = .none
        date.dateStyle = .short
        date.locale = Locale(identifier: "ja_JP")
        let today = Date()
        
        guard var dateData = UserDefaults.standard.array(forKey: "breakDay") as? [String] else {
            return
        }
        dateData.append(String(date.string(from: today).dropFirst(8)))
        UserDefaults.standard.set(dateData, forKey: "breakDay")
        
        guard var timeData = UserDefaults.standard.array(forKey: "breakTime") as? [String] else {
            return
        }
        timeData.append("1:00")
        UserDefaults.standard.set(timeData, forKey: "breakTime")
        
        
    }
    
    
    
    func getTime(TimeForKey: String, DayForKey: String){
        let time = DateFormatter()
        time.timeStyle = .short
        time.dateStyle = .none
        time.locale = Locale(identifier: "ja_JP")
        let now = Date()
        
        guard var timeData = UserDefaults.standard.array(forKey: TimeForKey) as? [String] else {
            return
        }
        timeData.append(time.string(from: now))
        UserDefaults.standard.set(timeData, forKey: TimeForKey)
        
        let date = DateFormatter()
        date.timeStyle = .none
        date.dateStyle = .short
        date.locale = Locale(identifier: "ja_JP")
        let today = Date()
        
        guard var dateData = UserDefaults.standard.array(forKey: DayForKey) as? [String] else {
            return
        }
        dateData.append(String(date.string(from: today).dropFirst(8)))
        UserDefaults.standard.set(dateData, forKey: DayForKey)
        
        
    }

    

}



