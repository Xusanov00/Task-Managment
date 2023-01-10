//
//  StartTaskVC.swift
//  TaskManagement
//
//  Created by Chingiz Jumanov on 05/01/23.
//

import UIKit
import CircleProgressView

class StartTaskVC: UIViewController {

    
    
    @IBOutlet weak var timerLbl: UILabel!
    
    @IBOutlet weak var progressView: CircleProgressView!
    
    
    //variables
    var progress = 0.0
    var totalTime = 10.0
    let totalProgress = 1.0
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNav()
        setProgressView()
    }
    
    func setProgressView() {
        progressView.progress = progress
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
    
    @IBAction func startTaskTapped(_ sender: Any) {
        
        
    }
}
