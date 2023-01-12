//
//  EndTaskVC.swift
//  Task_Managment
//
//  Created by Chingiz Jumanov on 07/01/23.
//

import UIKit
import CircleProgressView
class EndTaskVC: UIViewController {

    
    @IBOutlet weak var timerView: CircleProgressView!
    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var address: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    
    
    @IBAction func finishTapped(_ sender: Any) {
    }
    
    
    
}

//MARK: - UITextViewDelegate
extension EndTaskVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Write Comment"
            textView.textColor = UIColor.lightGray
        }
    }
    
}
extension EndTaskVC {
    func getTaskID() {
        
        API.getTaskID() { data in
            Loader.start()
            self.address.text = data.address
            self.timeLbl.text = "\(NSDate(timeIntervalSince1970: TimeInterval(data.time)))"
            self.titleLbl.text = data.title
            self.descLbl.text = data.definition
//            self.timerLbl.text = "\(NSDate(timeIntervalSince1970: TimeInterval(data.to)) - NSDate(timeIntervalSince1970: TimeInterval(data.from)))"
            Loader.stop()
        }
    }
}
