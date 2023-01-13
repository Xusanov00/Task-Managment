//
//  StartTaskVC.swift
//  TaskManagement
//
//  Created by Chingiz Jumanov on 05/01/23.
//

import UIKit
import CircleProgressView

class StartTaskVC: UIViewController {

    
    @IBOutlet weak var timerStack: UIStackView!
    
    @IBOutlet weak var timerView: CircleProgressView!
    @IBOutlet weak var timerTitleLbl: UILabel!
    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var laddressLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!

    
    
    //variables
   
    var timer: Timer!
    var value = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerStack.isHidden = true
        Loader.start()
        setUpNav()
        getTaskID()
    }
 
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            print("shake")
        }
    }

    
    func setUpTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if timerStack.isHidden {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear) {
                self.timerStack.isHidden = false
            } }
        
        timerView.setProgress(value, animated: true)
        timerLbl.text = "\(Int(value*100))"
        value -= 0.01
        if value <= 0 {
            timer.invalidate()
            timer = nil
            timerLbl.text = "Time Out"
        }
    }
    
    
    func setUpNav() {
        self.navigationItem.backButtonTitle = ""
        let alertBtn = UIBarButtonItem(image: UIImage(systemName: "bell.badge"), style: .done, target: self, action: #selector(alertTapped))
       
        alertBtn.tintColor = .black
        
        
        self.navigationItem.rightBarButtonItems = [alertBtn]
    }
    
    @objc func alertTapped() {
        let vc = ChatsVC.loadFromNib()
        vc.navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(ChatsVC.loadFromNib(), animated: true)
    }
    
    @IBAction func commentTapped(_ sender: Any) {
        ChatsVC.loadFromNib().navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(ChatsVC.loadFromNib(), animated: true)
    }
    
    
    
    
    
    @IBAction func startTaskTapped(_ sender: UIButton) {

        setUpTimer()
        sender.setTitle("Finish Task", for: .normal)
        
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
