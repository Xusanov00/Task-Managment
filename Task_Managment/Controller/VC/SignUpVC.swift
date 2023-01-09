//
//  SignUpVC.swift
//  TaskManagement
//
//  Created by MacBook Pro on 04/01/23.
//

import UIKit
import PhoneNumberKit
import PasswordTextField


class SignUpVC: UIViewController {

    @IBOutlet weak var signUpLbl: UILabel!
    @IBOutlet weak var signUpDescryptLbl: UILabel!
    @IBOutlet weak var numberTF: PhoneNumberTextField!
    @IBOutlet weak var passwordTF: UIView!
    
    
    @IBOutlet weak var continueBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setLanguage() 
        setTextField()
        continueBtn.addShadow(cornerRadius: 12)
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.navigationBar.tintColor = .black

    }
    
    //language details
    func setLanguage() {
        switch SetCache.getCache(for: KeysDM.language) {
        case LanguageEnum.uz.rawValue:
            signUpLbl.text = "Ro'yhatdan o'tish"
            signUpDescryptLbl.text = "Ro'yhatdan o'ting va hamma ishingizni re'ja asosida qilishni boshlang"
            continueBtn.setTitle("Davom etish", for: .normal)
        case LanguageEnum.ru.rawValue:
            signUpLbl.text = "Регистрация"
            signUpDescryptLbl.text = "Зарегестрируйтесь и начните выполнять все свои дела с планом"
            continueBtn.setTitle("Продолжить", for: .normal)
        case LanguageEnum.en.rawValue:
            signUpLbl.text = "Sign up"
            signUpDescryptLbl.text = "Sign up and start doing all your work with a plan"
            continueBtn.setTitle("Continue", for: .normal)
        default:
            print("")
        }

    }
    
    //textField settings
    func setTextField() {
        numberTF.defaultRegion = "UZ"
        numberTF.backgroundColor = .white
        numberTF.withFlag = true
        numberTF.withExamplePlaceholder = true
        numberTF.addShadow(cornerRadius: 12)
        passwordTF.addShadow(cornerRadius: 12)
    }

    
    @IBAction func continueTapped(_ sender: UIButton) {
            let vc = HomeVC(nibName: "HomeVC", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}



