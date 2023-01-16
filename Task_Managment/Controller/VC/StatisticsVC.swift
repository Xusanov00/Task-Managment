//
//  StatisticsVC.swift
//  Task_Managment
//
//  Created by MacBook Pro on 07/01/23.
//

import UIKit
import Charts
class StatisticsVC: UIViewController, ChartViewDelegate {
    
    
    //outlets
    @IBOutlet weak var diagramV: BarChartView!
    @IBOutlet weak var chartsV: LineChartView!
    
    //variables
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = Lang.getString(type: .statistics)
        setUpCharts()
        setUpNavigationV()
    }
    
    
    //MARK: - Set Up Charts
    func setUpCharts() {
        
        //Bar Chart
        diagramV.delegate = self
        var entries1 = [BarChartDataEntry]()
        for i in 0..<10 {
            entries1.append(BarChartDataEntry(x: Double(i), y: Double(i)))
        }
        let set1 = BarChartDataSet(entries: entries1)
        set1.colors = ChartColorTemplates.joyful()
        let data1 = BarChartData(dataSet: set1)
        diagramV.data = data1
        
        
        //Liner Chart
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
    
    
    //MARK: - Set Up NavigationController
    func setUpNavigationV () {
        let notificBtn = UIBarButtonItem(image: UIImage(systemName: "bell.badge"), style: .done, target: self, action: #selector(notificTapped))
        self.navigationItem.rightBarButtonItem = notificBtn
        self.navigationItem.rightBarButtonItem?.tintColor = .black
        self.navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    //objc func for notification btn actions
    @objc func notificTapped() {
        let vc = ChatsVC(nibName: "ChatsVC", bundle: nil)
        vc.navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(ChatsVC.loadFromNib(), animated: true)
    }
}



