//
//  LanguageVC.swift
//  TaskManagement
//
//  Created by MacBook Pro on 04/01/23.
//

import UIKit

class LanguageVC: UIViewController {
    
    
    //outlets
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet var langView: [UIView]!
    @IBOutlet var langBtn: [UIButton]!
    @IBOutlet weak var nextBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLang()
    }
    
    
    
    //MARK: - language and lang UI settings
    func setLang() {
        langView[0].addShadow(cornerRadius: 12)
        langView[1].addShadow(cornerRadius: 12)
        langView[2].addShadow(cornerRadius: 12)
        titleLbl.text = Lang.getString(type: .selectLang)
        nextBtn.setTitle(Lang.getString(type: .continu), for: .normal)
    }
    
    
    //MARK: - Actions
    @IBAction func continueTapped(_ sender: Any) {
        let vc = SignUpVC(nibName: "SignUpVC", bundle: nil)
        self.navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func languageTapped(_ sender: UIButton) {
        borderColor(tag: sender.tag)
        switch sender.tag {
        case 0:
            postNotif(lang: sender.tag)
            Cache.save(appLanguage: .uz)
        case 1:
            postNotif(lang: sender.tag)
            Cache.save(appLanguage: .ru)
        case 2:
            postNotif(lang: sender.tag)
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
extension LanguageVC {
    func postNotif(lang: Int) {
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "LANGNOTIFICATION"), object: lang, userInfo: nil)
        print("NotificationCenter LanguageVC \(lang)")
    }
}

//MARK: - NnotificationCenter for language changing
extension LanguageVC {
    func observeLangNotif() {
        NotificationCenter.default.addObserver(self, selector: #selector(changLang), name: NSNotification.Name.init(rawValue: "LANGNOTIFICATION"), object: nil)
        print("NotificationCenter LanguageVC")
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
