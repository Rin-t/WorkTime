//
//  DayDetailViewController.swift
//  WorkTime
//
//  Created by Rin on 2020/07/11.
//  Copyright © 2020 竹村凜. All rights reserved.
//

import UIKit

class DayDetailViewController: UIViewController {

    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet weak var button: UIButton!
    let cellTitle: [String] = ["出勤時刻","退勤時刻","休憩時間"]
    var setHour = "0"
    var setMinute = "0"
    var nextViewTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        detailTableView.backgroundColor = .white
//        memoTextView.backgroundColor = .white
        let decisionButton = CreateCircle(button: button)
        decisionButton.conversion()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(setHour)
        print(setMinute)
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
        cell.setCell(title: cellTitle[indexPath.row], time: "60")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        nextViewTitle = cellTitle[indexPath.row]
        print(nextViewTitle + "gi")
        performSegue(withIdentifier: "goToPicker", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! PickerViewController
        print(nextViewTitle)
        nextVC.receivedTitle = nextViewTitle
    }
    
    
    
}
