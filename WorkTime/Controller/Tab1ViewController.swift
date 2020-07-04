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
        UserDefaults.standard.register(defaults: ["data" : []])
        
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
        tapped()
    }
    
    @IBAction func finishButtonTapped(_ sender: UIButton) {
        tapped()
    }
    
    @IBAction func breakButtonTapped(_ sender: UIButton) {
        tapped()
    }
    
    
    
    //TappedMethod
    @objc func tapped() {
        guard var data = UserDefaults.standard.array(forKey: "data") as? [String] else {
            return
        }
        data.append(Date().description)
        UserDefaults.standard.set(data, forKey: "data")
        print(data)
    }
//    

    

}



