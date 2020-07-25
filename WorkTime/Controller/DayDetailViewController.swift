//
//  DayDetailViewController.swift
//  WorkTime
//
//  Created by Rin on 2020/07/11.
//  Copyright © 2020 竹村凜. All rights reserved.
//

import UIKit

class DayDetailViewController: UIViewController{
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var returnButton: UIButton!
    
    
    
    let cellTitle: [String] = ["出勤時刻","退勤時刻","休憩時間"]
    var cellTime: [String] = []
    var nextViewTitle = ""
    var ymd: WorkStatus!
    var todayData: [[String:String]] = [[:]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memoTextView.delegate = self
        detailTableView.isScrollEnabled = false
        
        let decisionButton = CreateCircle(button: button)
        decisionButton.conversion()
        returnButton.layer.cornerRadius = 20
        dateLabel.text = "\(ymd.year) / \(ymd.month) / \(ymd.day)"
        
        addDoneButtonOnKeyboard()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let data = UserDefaults.standard.object(forKey: "data") as? [[String: String]] else {
            return
        }
      
        let today = WorkStatus(year: ymd.year, month: ymd.month, day: ymd.day)
        
        //userdefaultからその日のデータを取得
        todayData = data.filter{ (ymd) -> Bool in
            ymd["年"] == today.year && Int(ymd["月"]!) == Int(today.month) && Int(ymd["日"]!) == Int(today.day)
        }
    
        if todayData != [] {
            cellTime.append(todayData[0]["出勤"]!)
            cellTime.append(todayData[0]["退勤"]!)
            cellTime.append(todayData[0]["休憩"]!)
            memoTextView.text = todayData[0]["memo"]
        } else {
            cellTime.append("")
            cellTime.append("")
            cellTime.append("")
        }

        detailTableView.reloadData()
        
    }
    
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        memoTextView.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction(){
        memoTextView.resignFirstResponder()
    }
    
    
    
    //MARK: - returnTapped
    
    @IBAction func returnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}



//MARK: - TableView
extension DayDetailViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell") as! DayDetailTableViewCell
        cell.setCell(title: cellTitle[indexPath.row], time: cellTime[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        nextViewTitle = cellTitle[indexPath.row]
        performSegue(withIdentifier: "goToPicker", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! PickerViewController
        nextVC.receivedTitle = nextViewTitle
        nextVC.todayData = todayData
        nextVC.ymd = ymd
        cellTime.removeAll()
    }
    
}

//MARK: - viewdeledate

extension DayDetailViewController: UITextViewDelegate{
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.memoTextView.resignFirstResponder()
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if todayData != [] {
            todayData[0]["memo"] = textView.text
        } else {
            todayData.append(["年": ymd.year, "月":ymd.month, "日": ymd.day, "出勤": "", "退勤":"", "休憩": "", "memo": textView.text])
        }
        print(todayData)
        guard var data = UserDefaults.standard.object(forKey: "data") as? [[String: String]] else {
            return
        }
        if data.count == 0 {
            data.append(todayData[0])
        } else {
            for i in 0...data.count - 1 {
                if data[i]["年"] == todayData[0]["年"] && data[i]["月"] == todayData[0]["月"] && data[i]["日"] == todayData[0]["日"] {
                    data[i]["memo"] = todayData[0]["memo"]
                } else if i == data.count - 1 {
                    data.append(todayData[0])
                }
            }
        }
        UserDefaults.standard.set(data, forKey: "data")
        
        
    }
    
}



