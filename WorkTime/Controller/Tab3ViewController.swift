//
//  Tab3ViewController.swift
//  WorkTime
//
//  Created by Rin on 2020/06/27.
//  Copyright © 2020 竹村凜. All rights reserved.
//

import UIKit
import Charts
import TinyConstraints

class Tab3ViewController: UIViewController {
    lazy var lineChrtView: LineChartView = {
            let chartView = LineChartView()
            chartView.backgroundColor = .systemBlue
            
            chartView.rightAxis.enabled = false
            
            let yAxis = chartView.leftAxis
            yAxis.labelFont = .boldSystemFont(ofSize: 12)
            yAxis.setLabelCount(6, force: false)
            yAxis.labelTextColor = .white
            yAxis.axisLineColor = .white
            yAxis.labelPosition = .insideChart
            
            chartView.xAxis.labelPosition = .bottom
            chartView.xAxis.labelFont = .boldSystemFont(ofSize: 12)
            chartView.xAxis.labelTextColor = .white
            chartView.xAxis.axisLineColor = .systemBlue
            
            chartView.animate(xAxisDuration: 0.8)
            
            return chartView
        }()

        override func viewDidLoad() {
            super.viewDidLoad()
            view.addSubview(lineChrtView)
            lineChrtView.centerInSuperview()
            lineChrtView.width(to: view)
            lineChrtView.heightToWidth(of: view)
            setData()
            // Do any additional setup after loading the view.
        }
        
    //    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
    //        print(entry)
    //    }
        
        func setData() {
            let set1 = LineChartDataSet(entries: yValues, label: "Subscribers")
            
            set1.mode = .cubicBezier
            //プロットの点を消せる
            set1.drawCirclesEnabled = false
            set1.lineWidth = 3
            set1.setColor(.white)
            set1.fill = Fill(color: .white)
            set1.fillAlpha = 0.5
            set1.drawFilledEnabled = true
            //let data = BarChartData(dataSet: set1)
            
           let data = LineChartData(dataSet: set1)
            
            //数値消せる
            data.setDrawValues(false)
            lineChrtView.data = data
        }
        
        let yValues: [ChartDataEntry] = [
            ChartDataEntry(x: 0.0, y: 10.0),
            ChartDataEntry(x: 1.0, y: 8.0),
            ChartDataEntry(x: 2.0, y: 14.0),
            ChartDataEntry(x: 3.0, y: 12.0),
            ChartDataEntry(x: 4.0, y: 18.0),
            ChartDataEntry(x: 5.0, y: 19.0),
            ChartDataEntry(x: 6.0, y: 22.0),
            ChartDataEntry(x: 7.0, y: 18.0),
            ChartDataEntry(x: 8.0, y: 20.0),
            ChartDataEntry(x: 9.0, y: 25.0),
            ChartDataEntry(x: 10.0, y: 29.0),
            ChartDataEntry(x: 11.0, y: 35.0),
            ChartDataEntry(x: 12.0, y: 34.0),
            ChartDataEntry(x: 13.0, y: 37.0),
            ChartDataEntry(x: 14.0, y: 40.0)
        
        ]
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
