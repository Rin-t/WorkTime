//
//  PickerViewController.swift
//  WorkTime
//
//  Created by Rin on 2020/07/18.
//  Copyright © 2020 竹村凜. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var decisionButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var setHour = "0"
    var setMinute = "0"
    var receivedTitle = ""
    
    let hour = ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23"]
    var minutes:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        returnButton.layer.cornerRadius = 20
        
        titleLabel.text = receivedTitle
        
        //決定ボタンを円にコンバート
        let decisionButtonConvert = CreateCircle(button: decisionButton)
        decisionButtonConvert.conversion()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        for i in 0...59{
            minutes.append(String(i))
        }
        self.pickerView.setValue(UIColor.black, forKey: "textColor")
        
    }
    
    @IBAction func returnTapped(_ sender: Any) {
       
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func decisionTapped(_ sender: UIButton) {
        
        let preVC = self.presentingViewController as! DayDetailViewController
        preVC.setHour = setHour
        preVC.setMinute = setMinute
        dismiss(animated: true, completion: nil)
               
    }
    
    
}

extension PickerViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return hour.count
        case 1:
            return 1
        case 2:
            return minutes.count
        case 3:
            return 1
        default:
            return 0
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component{
        case 0:
            return hour[row]
        case 1:
            return "時"
        case 2:
            return minutes[row]
        case 3:
            return "分"
        default:
            return "error"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component{
        case 0:
            setHour = hour[row]
        case 2:
            setMinute = minutes[row]
        default:
            return
        }
        
    }
    //    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    //
    //        let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 50))
    //        label.textAlignment = .center
    //        label.text = hour[row]
    //        label.font = UIFont(name: "Zapfino",size:16)
    //        label.textColor = .red
    //        return label
    //    }
    
}





