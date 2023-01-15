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
    var userData: UserDM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pandingCount.layer.cornerRadius = pandingCount.frame.height/2
        
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationItem.hidesBackButton = true
        getData()
        observeUserNotif()
        observeLangNotif()
        setLang()
        getHomeData()
    }
    
    
    //localizatedLanguage
    func setLang() {
        statisticsBtn.setTitle(Lang.getString(type: .statistics), for: .normal)
        todaysTaskLbl.text = Lang.getString(type: .todaysTasks)
        viewTaskBtn.setTitle(Lang.getString(type: .todaysTasks), for: .normal)
    }
    
    
    @IBAction func profileBtnTapped(_ sender: Any) {
        let vc = ProfileVC.loadFromNib()
        vc.userData = userData
        navigationController?.pushViewController(vc, animated: true)
        navigationItem.backButtonTitle = ""
    }
    
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
            Loader.stop()
            self.progressV.progress = Double(data.pecent)
            self.progressLbl.text = "\(data.pecent)%"
            self.tasksCompletedLbl.text = "\(data.complatedTask)/\(data.allTasks) " + Lang.getString(type: .tasksCompleted)
            self.pandingCount.text = "\(data.pendingCount)"
            
        }
    }
}








//extension HomeVC {
//    func observeLangNotif() {
//        NotificationCenter.default.addObserver(self, selector: #selector(changLang), name: NSNotification.Name.init(rawValue: "LANGNOTIFICATION"), object: nil)
//        print("Notification HomeVC")
//    }
//    @objc func changLang(_ notification: NSNotification) {
//        guard let lang = notification.object as? Int else { return }
//        print("Notification HomeVC1")
//        switch lang {
//        case 0:
//            Cache.save(appLanguage: .uz)
//            setLang()
//        case 1:
//            Cache.save(appLanguage: .ru)
//            setLang()
//        case 2:
//            Cache.save(appLanguage: .en)
//            setLang()
//        default: break
//        }
//    }
//}

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

