//
//  StartVC.swift
//  TaskManagement
//
//  Created by MacBook Pro on 04/01/23.
//

import UIKit

class StartVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      
    }


    @IBAction func startTapped(_ sender: Any) {
        let vc = LanguageVC(nibName: "LanguageVC", bundle: nil)
        self.navigationItem.backButtonTitle = ""
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    

}
