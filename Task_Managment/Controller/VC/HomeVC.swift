//
//  HomeVC.swift
//  TaskManagement
//
//  Created by MacBook Pro on 05/01/23.
//

import UIKit
import FSCalendar
import Charts
import CircleProgressView
class HomeVC: UIViewController, ChartViewDelegate,FSCalendarDelegate,FSCalendarDataSource {

    @IBOutlet weak var progressLbl: UILabel!
    @IBOutlet weak var calendarV: UIView!
    @IBOutlet weak var progressV: CircleProgressView!
    @IBOutlet weak var diagramV: BarChartView!
    @IBOutlet weak var chartsV: LineChartView!
    var progressLayer = CAShapeLayer()
    fileprivate var trackLayer = CAShapeLayer()
    var lineChart = LineChartView()
    fileprivate weak var calendar: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.navigationBar.tintColor = .black


        setUpCharts()
        progressLbl.text = "\(progressV.progress * 100)%"
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
   

    
    @IBAction func profileBtnTapped(_ sender: Any) {
        navigationController?.pushViewController(ProfileVC.loadFromNib(), animated: true)
        navigationItem.backButtonTitle = ""
    }
 
    @IBAction func taskTapped(_ sender: Any) {
        let vc = TodaysTaskVC(nibName: "TodaysTaskVC", bundle: nil)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    

}

