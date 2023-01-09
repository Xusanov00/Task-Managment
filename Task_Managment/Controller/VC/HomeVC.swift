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
  
    fileprivate weak var calendar: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.navigationBar.tintColor = .black
        progressLbl.text = "\(progressV.progress * 100)%"
        self.navigationItem.hidesBackButton = true
    }
    
   

    
    @IBAction func profileBtnTapped(_ sender: Any) {
        navigationController?.pushViewController(ProfileVC.loadFromNib(), animated: true)
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

