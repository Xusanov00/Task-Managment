//
//  StartTaskVC.swift
//  TaskManagement
//
//  Created by Chingiz Jumanov on 05/01/23.
//

import UIKit
import CircleProgressView

class StartTaskVC: UIViewController {

    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var timLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var laddressLbl: UILabel!
    
    
    @IBOutlet weak var descLbl: UILabel!
    
    
    @IBOutlet weak var progressView: CircleProgressView!
    
    
    //variables
   
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Loader.start()
        setUpNav()
        
        getTaskID()
    }
 
    
    
    
    func setUpNav() {
        self.navigationItem.backButtonTitle = ""
        let alertBtn = UIBarButtonItem(image: UIImage(systemName: "bell.badge"), style: .done, target: self, action: #selector(alertTapped))
       
        alertBtn.tintColor = .black
        
        
        self.navigationItem.rightBarButtonItems = [alertBtn]
    }
    
    @objc func alertTapped() {
        let vc = ChatsVC(nibName: "ChatsVC", bundle: nil)
        vc.navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(ChatsVC.loadFromNib(), animated: true)
    }
    
    @IBAction func commentTapped(_ sender: Any) {
        ChatsVC.loadFromNib().navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(ChatsVC.loadFromNib(), animated: true)
    }
    
    
    
    
    
    @IBAction func startTaskTapped(_ sender: Any) {
        EndTaskVC.loadFromNib().navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(EndTaskVC.loadFromNib(), animated: true)
        
    }
}
extension StartTaskVC {
    func getTaskID() {
        API.getTaskID() { data in
           
            self.dateLbl.text = "\(NSDate(timeIntervalSince1970: TimeInterval(data.from)))"
            self.laddressLbl.text = data.address
            self.timeLbl.text = "\(NSDate(timeIntervalSince1970: TimeInterval(data.time)))"
            self.titleLbl.text = data.title
            self.descLbl.text = data.definition
            Loader.stop()
            
        }
    }
}
