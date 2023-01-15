//
//  ChangeLangVC.swift
//  Task_Managment
//
//  Created by Ali on 14/01/23.
//

import UIKit

class ChangeLangVC: UIViewController {
    
    @IBOutlet weak var selectLangLbl: UILabel!
    @IBOutlet var langView: [UIView]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLang()
    }
    
    
    func setLang() {
        selectLangLbl.text = Lang.getString(type: .selectLang)
    }
    
    
    @IBAction func langChanged(_ sender: UIButton) {
        borderColor(tag: sender.tag)
        postNotif(lang: sender.tag)
        switch sender.tag {
        case 0:
            Cache.save(appLanguage: .uz)
        case 1:
            Cache.save(appLanguage: .ru)
        case 2:
            Cache.save(appLanguage: .en)
        default:
            print("error select language button tag")
        }
        setLang()
    }
    
    //MARK: - Border Color for LangBtn
    func borderColor(tag: Int) {
        langView[0].borderColor = .clear
        langView[1].borderColor = .clear
        langView[2].borderColor = .clear
        langView[tag].borderColor = #colorLiteral(red: 0.324398458, green: 0.3902252913, blue: 0.9221590161, alpha: 1)
    }
}


//MARK: -Lang Notif
extension ChangeLangVC {
    func postNotif(lang: Int) {
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "LANGNOTIFICATION"), object: lang, userInfo: nil)
        
        switch lang {
        case 0:
            Cache.save(appLanguage: .uz)
        case 1:
            Cache.save(appLanguage: .ru)
        case 2:
            Cache.save(appLanguage: .en)
        default:
            print("notif lang default")
        }
    }
}

