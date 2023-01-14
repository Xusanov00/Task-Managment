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
class HomeVC: UIViewController {
    
    @IBOutlet weak var progressLbl: UILabel!
    @IBOutlet weak var calendarV: UIView!
    @IBOutlet weak var progressV: CircleProgressView!
    @IBOutlet weak var statisticsBtn: UIButton!
    @IBOutlet weak var numberLbl: UILabel!
    @IBOutlet weak var fullnameLbl: UILabel!
    @IBOutlet weak var todaysTaskLbl: UILabel!
    @IBOutlet weak var tasksCompletedLbl: UILabel!
    @IBOutlet weak var viewTaskBtn: UIButton!
    @IBOutlet weak var pandingCount: UILabel!
    
    var calendar: FSCalendar!
    var formatter = DateFormatter()
    var number = ""
    var userData: UserDM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pandingCount.layer.cornerRadius = pandingCount.frame.height/2
        setCalendar()
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationItem.hidesBackButton = true
        getData()
        observeUserNotif()
        setLang()
        getHomeData()
        progressV.setProgress(0, animated: true)
    }
//    SetCalendar
    func setCalendar() {
        calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: self.calendarV.frame.width, height: self.calendarV.frame.height))
        calendar.scrollDirection = .horizontal
        calendar.scope = .week
        calendar.locale = Locale(identifier: "uz")
        calendar.delegate = self
        calendar.dataSource = self
        self.calendarV.addSubview(calendar)
    }
    
    
    
    //localizatedLanguage
    func setLang() {
        //        statisticsBtn.setTitle("Statistics".localized(), for: .normal)
        //        todaysTaskLbl.text = "Today’s Tasks".localized()
        //        tasksCompletedLbl.text = number + "Tasks completed".localized()
        //        viewTaskBtn.setTitle("View Task".localized(), for: .normal)
    }
    
    //profileBtnTapped
    @IBAction func profileBtnTapped(_ sender: Any) {
        let vc = ProfileVC.loadFromNib()
        vc.userData = userData
        navigationController?.pushViewController(vc, animated: true)
        navigationItem.backButtonTitle = ""
    }
//openChatsTapped
    @IBAction func openChatsTapped(_ sender: Any) {
        let vc = ChatsVC(nibName: "ChatsVC", bundle: nil)
        vc.navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(ChatsVC.loadFromNib(), animated: true)
    }
    @IBAction func taskTapped(_ sender: Any) {
        let vc = TodaysTaskVC(nibName: "TodaysTaskVC", bundle: nil)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func statistictsTapped(_ sender: Any) {
        let vc = StatisticsVC.loadFromNib()
        vc.navigationController?.navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

//MARK: - FSCalendarDelegate
extension HomeVC:FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        formatter.dateFormat = "dd-MM-yyyy"
         
        let vc = TodaysTaskVC(nibName: "TodaysTaskVC", bundle: nil)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
//MARK: - FSCalendarDataSource
extension HomeVC:FSCalendarDataSource {
    func minimumDate(for calendar: FSCalendar) -> Date {
        return calendar.minimumDate
    }
    func maximumDate(for calendar: FSCalendar) -> Date {
        return calendar.maximumDate
    }
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        formatter.dateFormat = "dd-MM-yyyy"
        guard let eventData = formatter.date(from: "15-01-2020") else {return 0}
        if date.compare(eventData) == .orderedSame {
            return 3
        }
        return 0
    }
}


//MARK: Data from API
extension HomeVC {
    func getData () {
        Loader.start()
        API.getProfile {[self] data in
            userData = data
            guard let data = userData else { return }
            self.fullnameLbl.text = data.lastName + " " + data.firstName
            self.numberLbl.text = data.phoneNumber
            Loader.stop()
            
        }
    }
}

//MARK: - Observe Notification Center
extension HomeVC {
    func observeUserNotif() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateUser), name: NSNotification.Name.init("UPDATEUSER"), object: nil)
    }
    
    @objc func updateUser() {
        getData()
    }
}


//MARK: - getHomePageData
extension HomeVC {
    func getHomeData() {
        API.getMainPage { data in
            Loader.stop()
            self.progressV.setProgress(Double(data.pecent)/100, animated: true)
            self.progressLbl.text = "\(data.pecent)%"
            self.tasksCompletedLbl.text = "\(data.complatedTask)/\(data.allTasks) Task Completed"
            self.pandingCount.text = "\(data.pendingCount)"
            
        }
    }
}
