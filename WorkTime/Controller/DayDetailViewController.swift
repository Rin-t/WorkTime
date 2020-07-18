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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailTableView.backgroundColor = .white
        memoTextView.backgroundColor = .white
        let decisionButton = CreateCircle(button: button)
        decisionButton.conversion()

        // Do any additional setup after loading the view.
    }

}

extension DayDetailViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell") as! DayDetailTableViewCell
        cell.setCell(title: "出勤時間", time: "60")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToPicker", sender: nil)
    }
    
    
}
