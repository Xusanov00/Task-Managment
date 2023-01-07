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
    @IBOutlet weak var progressV: UIView!
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
        setUpProgressV()
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
    func setUpProgressV() {
        let circlePath = UIBezierPath(arcCenter: progressV.center, radius: progressV.frame.width/2, startAngle: CGFloat.pi / 2, endAngle: CGFloat.pi * 2, clockwise: true)
        
        trackLayer.path = circlePath.cgPath
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = UIColor.blue.cgColor
        trackLayer.lineWidth = 16
        trackLayer.strokeEnd = 1.0
        trackLayer.lineCap = CAShapeLayerLineCap.round
        progressV.layer.addSublayer(trackLayer)
        
        progressLayer.path = circlePath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = UIColor.systemGray.cgColor
        progressLayer.lineWidth = 16
        progressLayer.strokeEnd = 0.0
        progressV.layer.addSublayer(progressLayer)
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 3
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        progressLayer.add(basicAnimation, forKey: "usSoBasic")
        
    }

    
    @IBAction func profileBtnTapped(_ sender: Any) {
        navigationController?.pushViewController(ProfileVC.loadFromNib(), animated: true)
        navigationItem.backButtonTitle = ""
    }
//    func setCalendar() {
//
//        let calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 32, height: 280))
//        calendar.dataSource = self
//        calendar.delegate = self
//        calendarV.addSubview(calendar)
//
//        self.calendar = calendar
//    }
    
    @IBAction func taskTapped(_ sender: Any) {
        
        self.navigationController?.pushViewController(TodaysTaskVC(nibName: "TodaysTaskVC", bundle: nil), animated: true)
    }
    
    
    

}

