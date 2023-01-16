//
//  StartVC.swift
//  TaskManagement
//
//  Created by MacBook Pro on 04/01/23.
//

import UIKit

class StartVC: UIViewController {
    
    //outlets
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var commentLbl: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLang()
        
    }
    
    
    
    //MARK: lagnuage settings
    func setLang() {
        titleLbl.text = Lang.getString(type: .startVCTitle)
        commentLbl.text = Lang.getString(type: .startVCDescrypt)
        nextBtn.setTitle(Lang.getString(type: .getStart), for: .normal)
    }
    
    
    //MARK: - Actions
    @IBAction func startTapped(_ sender: Any) {
        let vc = LanguageVC(nibName: "LanguageVC", bundle: nil)
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - NnotificationCenter for language changing
extension StartVC {
    func observeLangNotif() {
        NotificationCenter.default.addObserver(self, selector: #selector(changLang), name: NSNotification.Name.init(rawValue: "LANGNOTIFICATION"), object: nil)
        print("NotificationCenter StartVC")
    }
    @objc func changLang(_ notification: NSNotification) {
        guard let lang = notification.object as? Int else { return }
        switch lang {
        case 0:
            Cache.save(appLanguage: .uz)
            setLang()
        case 1:
            Cache.save(appLanguage: .ru)
            setLang()
        case 2:
            Cache.save(appLanguage: .en)
            setLang()
        default: break
        }
    }
}
