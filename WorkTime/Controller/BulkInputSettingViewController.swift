//
//  BulkInputSettingViewController.swift
//  WorkTime
//
//  Created by Rin on 2020/08/02.
//  Copyright © 2020 竹村凜. All rights reserved.
//

import UIKit

class BulkInputSettingViewController: UIViewController {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var decisionButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var hourUnitLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var minuteUnitLabel: UILabel!
    
    
    var setHour = "0"
    var setMinute = "00"
    var receivedTitle = ""
    var todayData: [[String: String]] = [[:]]
    var ymd: WorkStatus!
    
    let hour = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"]
    var minutes: [String] = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if receivedTitle == "出勤時刻" || receivedTitle == "退勤時刻" {
            hourUnitLabel.text = "時"
            minuteUnitLabel.text = "分"
        } else {
            hourUnitLabel.text = "時間"
            minuteUnitLabel.text = "分"
        }
        
        returnButton.layer.cornerRadius = 20
        
        titleLabel.text = receivedTitle
        
        //決定ボタンを円にコンバート
        let decisionButtonConvert = CreateCircle(button: decisionButton)
        decisionButtonConvert.conversion()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        for i in 10...59 {
            minutes.append(String(i))
        }
        self.pickerView.setValue(UIColor.black, forKey: "textColor")
        
    }
    
    @IBAction func returnTapped(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func decisionTapped(_ sender: UIButton) {
        var defaultTime = UserDefaults.standard.object(forKey: "defaultTime") as? [String]
        if receivedTitle == "出勤時刻" {
            defaultTime![0] = setHour + ":" + setMinute
        } else if receivedTitle == "退勤時刻" {
            defaultTime![1] = setHour + ":" + setMinute
        } else {
            defaultTime![2] = setHour + ":" + setMinute
        }
        
        UserDefaults.standard.set(defaultTime, forKey: "defaultTime")
        dismiss(animated: true, completion: nil)
    }
}
    
    extension BulkInputSettingViewController: UIPickerViewDelegate, UIPickerViewDataSource {
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 2
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            switch component {
            case 0:
                return hour.count
            case 1:
                return minutes.count
            default:
                return 0
            }
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            switch component {
            case 0:
                return hour[row]
            case 1:
                return minutes[row]
            default:
                return "error"
            }
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            switch component {
            case 0:
                setHour = hour[row]
                hourLabel.text = hour[row]
            case 1:
                setMinute = minutes[row]
                minuteLabel.text = minutes[row]
            default:
                return
            }
            
        }
        
    }
    
    
