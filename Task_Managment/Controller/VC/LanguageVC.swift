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
//        titleLbl.text = "Select Language".localized()
//        nextBtn.setTitle("Continue".localized(), for: .normal)
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
            SetCache.saveCache(for: LanguageEnum.uz.rawValue, for: KeysDM.language)
        case 1:
            SetCache.saveCache(for: LanguageEnum.ru.rawValue, for: KeysDM.language)
        case 2:
            SetCache.saveCache(for: LanguageEnum.en.rawValue, for: KeysDM.language)
        default:
            print("error select language button tag")
        }
    }
    
    //MARK: - Border Color for LangBtn
    func borderColor(tag: Int) {
        langView[0].borderColor = .clear
        langView[1].borderColor = .clear
        langView[2].borderColor = .clear
        langView[tag].borderColor = #colorLiteral(red: 0.324398458, green: 0.3902252913, blue: 0.9221590161, alpha: 1)
    }
}



