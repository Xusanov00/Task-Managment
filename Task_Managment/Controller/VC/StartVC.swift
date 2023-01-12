//
//  StartVC.swift
//  TaskManagement
//
//  Created by MacBook Pro on 04/01/23.
//

import UIKit

class StartVC: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var commentLbl: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLang()
    }

    //MARK: lagnuage settings
    func setLang() {
        titleLbl.text = "Task Management & To-Do List".localized()
        commentLbl.text = "This productive tool is designed to help you better manage your task project-wise conveniently!".localized()
        nextBtn.setTitle("Get Started".localized(), for: .normal)
    }
    
    

    @IBAction func startTapped(_ sender: Any) {
        let vc = LanguageVC(nibName: "LanguageVC", bundle: nil)
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.navigationBar.tintColor = .black

        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    

}
