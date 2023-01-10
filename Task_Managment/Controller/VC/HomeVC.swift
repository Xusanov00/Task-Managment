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
class HomeVC: UIViewController,FSCalendarDelegate,FSCalendarDataSource {

    @IBOutlet weak var progressLbl: UILabel!
    @IBOutlet weak var calendarV: UIView!
    @IBOutlet weak var progressV: CircleProgressView!
  
    @IBOutlet weak var numberLbl: UILabel!
    @IBOutlet weak var fullnameLbl: UILabel!
    fileprivate weak var calendar: FSCalendar!
    
    var userData: UserDM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationItem.hidesBackButton = true
        getData()
        observeUserNotif()
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

extension HomeVC {
    func observeUserNotif() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateUser), name: NSNotification.Name.init("UPDATEUSER"), object: nil)
    }
    
    @objc func updateUser() {
        getData()
    }
}
