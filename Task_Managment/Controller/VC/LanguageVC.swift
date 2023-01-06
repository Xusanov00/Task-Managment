//
//  LanguageVC.swift
//  TaskManagement
//
//  Created by MacBook Pro on 04/01/23.
//

import UIKit

class LanguageVC: UIViewController {

    
    @IBOutlet var backV: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addShadow()
    }
    func addShadow() {
        for i in backV {
            i.layer.masksToBounds = false
            i.layer.shadowOffset = CGSize(width: 0, height: 0)
            i.layer.shadowRadius = 5
            i.layer.shadowOpacity = 0.2
            i.layer.cornerRadius = 10
            i.layer.shadowColor = UIColor.systemGray.cgColor
        }
    }

    @IBAction func continueTapped(_ sender: Any) {
        let vc = SignUpVC(nibName: "SignUpVC", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func languageTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            SetCache.saveCache(for: LanguageDM.uz.rawValue, for: KeysDM.language)
        case 1:
            SetCache.saveCache(for: LanguageDM.ru.rawValue, for: KeysDM.language)
        case 2:
            SetCache.saveCache(for: LanguageDM.en.rawValue, for: KeysDM.language)
        default:
            print("error select language button tag")
        }
    }
    
}
