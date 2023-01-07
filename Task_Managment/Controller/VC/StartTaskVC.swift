//
//  StartTaskVC.swift
//  TaskManagement
//
//  Created by Chingiz Jumanov on 05/01/23.
//

import UIKit

class StartTaskVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNav()
        
    }
    
    func setUpNav() {
        self.navigationItem.backButtonTitle = ""
        let alertBtn = UIBarButtonItem(image: UIImage(systemName: "bell.badge"), style: .done, target: self, action: #selector(alertTapped))
       
        alertBtn.tintColor = .black
        
        
        self.navigationItem.rightBarButtonItems = [alertBtn]
    }
    
    @objc func alertTapped() {
        //Alert
    }
    
}
