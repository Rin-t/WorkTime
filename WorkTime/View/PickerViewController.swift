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
    
    let hour = ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23"]
    var minutes:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        for i in 1...59{
            minutes.append(String(i))
        }
        self.pickerView.setValue(UIColor.black, forKey: "textColor")
        // Do any additional setup after loading the view.
    }
    



}

extension PickerViewController: UIPickerViewDelegate, UIPickerViewDataSource{
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
        switch component{
        case 0:
            return hour[row]
        case 1:
            return minutes[row]
        default:
            return "error"
        }
    }

}
    
    
    
    

