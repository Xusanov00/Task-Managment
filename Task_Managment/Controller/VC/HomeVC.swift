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
import SkeletonView

class HomeVC: UIViewController {
    
    @IBOutlet weak var backView: UIView!
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
        observeLangNotif()
        setLang()
        getHomeData()
        progressV.setProgress(0, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //setUpSkeletonView()
    }
//    SetCalendar
    func setCalendar() {
        calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: self.calendarV.frame.width, height: self.calendarV.frame.height))
        calendar.scrollDirection = .horizontal
        calendar.scope = .month
        calendar.locale = Locale(identifier: "uz")
        calendar.delegate = self
        calendar.dataSource = self
        self.calendarV.addSubview(calendar)
    }
    
    
    
    func setUpSkeletonView() {
        backView.isSkeletonable = true
        calendarV.isSkeletonable = true
        progressV.isSkeletonable = true
        progressLbl.isSkeletonable = true
        statisticsBtn.isSkeletonable = true
        numberLbl.isSkeletonable = true
        fullnameLbl.isSkeletonable = true
        todaysTaskLbl.isSkeletonable = true
        tasksCompletedLbl.isSkeletonable = true
        viewTaskBtn.isSkeletonable = true
        pandingCount.isSkeletonable = true
        progressV.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .concrete), animation: .none, transition: .crossDissolve(0.25))
        progressLbl.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .concrete), animation: .none, transition: .crossDissolve(0.25))
        statisticsBtn.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .concrete), animation: .none, transition: .crossDissolve(0.25))
        numberLbl.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .concrete), animation: .none, transition: .crossDissolve(0.25))
        fullnameLbl.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .concrete), animation: .none, transition: .crossDissolve(0.25))
        todaysTaskLbl.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .concrete), animation: .none, transition: .crossDissolve(0.25))
        tasksCompletedLbl.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .concrete), animation: .none, transition: .crossDissolve(0.25))
        viewTaskBtn.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .concrete), animation: .none, transition: .crossDissolve(0.25))
        pandingCount.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .concrete), animation: .none, transition: .crossDissolve(0.25))
        calendarV.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .concrete), animation: .none, transition: .crossDissolve(0.25))
        backView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .concrete), animation: .none, transition: .crossDissolve(0.25))
        
        
    }
    
    //localizatedLanguage
    func setLang() {
        statisticsBtn.setTitle(Lang.getString(type: .statistics), for: .normal)
        todaysTaskLbl.text = Lang.getString(type: .todaysTasks)
        viewTaskBtn.setTitle(Lang.getString(type: .todaysTasks), for: .normal)
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
//        Loader.start()
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
            self.progressV.setProgress(Double(data.pecent)/100, animated: true)
            self.progressLbl.text = "\(data.pecent)%"
            self.tasksCompletedLbl.text = "\(data.complatedTask)/\(data.allTasks) " + Lang.getString(type: .tasksCompleted)
            self.pandingCount.text = "\(data.pendingCount)"
            Loader.stop()
            
        }
    }
}




//MARK: - NnotificationCenter for language changing
extension HomeVC {

    func observeLangNotif() {
        NotificationCenter.default.addObserver(self, selector: #selector(changeLang), name: NSNotification.Name.init(rawValue: "LANGNOTIFICATION"), object: nil)
    }

    @objc func changeLang(_ notification: NSNotification) {
        guard let lang = notification.object as? Int else { return }
        switch lang {
        case 0:
            Cache.save(appLanguage: .uz)
            setLang()
        case 1:
            Cache.save(appLanguage: .ru)
            setLang()
        case 2:
            Cache.save(appLanguage: .en)
            setLang()
        default: break
        }

        setLang()
        print("home language updated to ", Cache.getAppLanguage())
    }
}

