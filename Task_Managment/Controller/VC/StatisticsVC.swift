//
//  StatisticsVC.swift
//  Task_Managment
//
//  Created by MacBook Pro on 07/01/23.
//

import UIKit
import Charts
class StatisticsVC: UIViewController, ChartViewDelegate {

    @IBOutlet weak var diagramV: BarChartView!
    
    @IBOutlet weak var chartsV: LineChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Statistics"
        
         setUpCharts()
        setUpNavigationV()
    }
    func setUpCharts() {
//        Bar Chart
        diagramV.delegate = self
        var entries1 = [BarChartDataEntry]()
        for i in 0..<10 {
            entries1.append(BarChartDataEntry(x: Double(i), y: Double(i)))
        }
        let set1 = BarChartDataSet(entries: entries1)
        set1.colors = ChartColorTemplates.joyful()
        let data1 = BarChartData(dataSet: set1)
        diagramV.data = data1
        
        
//        Liner Chart
        
        chartsV.delegate = self
        var entries = [ChartDataEntry]()
        for i in 0..<10 {
            entries.append(ChartDataEntry(x: Double(i), y: Double(i)))
        }
        let set = LineChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.material()
        let data = LineChartData(dataSet: set)
        chartsV.data = data
    }

    func setUpNavigationV () {
        let notificBtn = UIBarButtonItem(image: UIImage(systemName: "bell.badge"), style: .done, target: self, action: #selector(notificTapped))
        self.navigationItem.rightBarButtonItem = notificBtn
        self.navigationItem.rightBarButtonItem?.tintColor = .black
        self.navigationItem.leftBarButtonItem?.tintColor = .black
    }
    @objc func notificTapped() {
        
    }

}
