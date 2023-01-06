//
//  HomeVC.swift
//  TaskManagement
//
//  Created by MacBook Pro on 05/01/23.
//

import UIKit
import FSCalendar
import Charts
class HomeVC: UIViewController, ChartViewDelegate,FSCalendarDelegate,FSCalendarDataSource {

    @IBOutlet weak var calendarV: UIView!
    @IBOutlet weak var diagramV: UIView!
    
    @IBOutlet weak var chartsV: UIView!
    var lineChart = LineChartView()
    
    fileprivate weak var calendar: FSCalendar!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backButtonTitle = ""
        
        setCalendar()
        setUpCharts()
    }
    func setUpCharts() {
        lineChart.frame = CGRect(x: 0, y: 0, width: chartsV.frame.width, height: chartsV.frame.height)
        lineChart.delegate = self
        lineChart.center = chartsV.center
        chartsV.addSubview(lineChart)
        var entries = [ChartDataEntry]()
        for i in 0..<10 {
            entries.append(ChartDataEntry(x: Double(i), y: Double(i)))
        }
        let set = LineChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.material()
        let data = LineChartData(dataSet: set)
        lineChart.data = data
    }
    
    
    
    
    
    
    
    func setCalendar() {
        
        let calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 32, height: 280))
        calendar.dataSource = self
        calendar.delegate = self
        calendarV.addSubview(calendar)
        
        self.calendar = calendar
    }
    
    @IBAction func taskTapped(_ sender: Any) {
        
        self.navigationController?.pushViewController(TodaysTaskVC(nibName: "TodaysTaskVC", bundle: nil), animated: true)
    }
    
    
    

}

