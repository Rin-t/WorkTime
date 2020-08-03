//
//  Tab3ViewController.swift
//  WorkTime
//
//  Created by Rin on 2020/07/25.
//  Copyright © 2020 竹村凜. All rights reserved.
//

import UIKit

class Tab3ViewController: UIViewController {
    @IBOutlet weak var settingTableView: UITableView!
    @IBOutlet weak var tableView: UITableView!
    let titles = ["出勤時刻", "退勤時刻", "休憩時間"]
    var nextViewTitle = ""
    var defaultTime: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTableView.isScrollEnabled = false
        settingTableView.delegate = self
        settingTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        defaultTime = UserDefaults.standard.object(forKey: "defaultTime") as? [String] ?? ["9:00", "18:00", "1:00"]
        tableView.reloadData()
    }
    

    

}


extension Tab3ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailSettingCell") as! DetailSettngTableViewCell
        cell.setCell(title: titles[indexPath.row], time: defaultTime[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        nextViewTitle = titles[indexPath.row]
        performSegue(withIdentifier: "toBulkInputSetting", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! BulkInputSettingViewController
        nextVC.receivedTitle = nextViewTitle
        
        
        
    }
    
    
    
}
