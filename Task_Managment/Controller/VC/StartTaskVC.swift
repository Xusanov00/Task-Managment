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
        self.navigationItem.backBarButtonItem?.image = UIImage(systemName: "chevron.left")
        
        let alertBtn = UIBarButtonItem(image: UIImage(systemName: "bell.badge"), style: .done, target: self, action: #selector(alertTapped))
        let backBtn = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .done, target: self, action: #selector(alertTapped))
        alertBtn.tintColor = .black
        backBtn.tintColor = .black
        self.navigationItem.leftBarButtonItem = backBtn
        self.navigationItem.rightBarButtonItems = [alertBtn]
    }
    
    @objc func alertTapped() {
        //Alert
    }
    
}
