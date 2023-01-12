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
    @IBOutlet weak var privasyLbl: UITextView!
    
    @IBOutlet weak var passTf: PasswordTextField!
    
    @IBOutlet weak var continueBtn: UIButton!
//
//    let message = "By continuing, you agree to the Terms of Use and Privacy Policy".localized()
//    let findWord = ["Terms of Use".localized(), "Privacy Policy".localized()]
//
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLanguage() 
        setTextField()
        privacyPolicyLabel()
        continueBtn.addShadow(cornerRadius: 12)
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.navigationBar.tintColor = .black
        
        DispatchQueue.main.async {
            if Reachability.isConnectedToNetwork() {
                Loader.stop()
            } else {
                Loader.start()
            }
        }

    }
    
    
    
    //
    func privacyPolicyLabel() {
//        let attributeMutableStringLink = NSMutableAttributedString(string: message)
//        attributeMutableStringLink.addAttribute(.link, value: "https://www.google.co.in/", range:
//        message.createRangeinaLink(of: findWord[0]))
//        attributeMutableStringLink.addAttribute(.link, value: "https://www.youtube.com/", range:
//        message.createRangeinaLink(of: findWord[1]))
//        privasyLbl.attributedText = attributeMutableStringLink
    }
    
    
    //language details
    func setLanguage() {
//       signUpLbl.text = "Sign up".localized()
//       signUpDescryptLbl.text = "Sign up and start doing all your work with a plan".localized()
//        continueBtn.setTitle("Continue".localized(), for: .normal)
//        passTf.placeholder = "Password".localized()
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
        let num = numberTF.text!.replacingOccurrences(of: " ", with: "")
        let pass = passTf.text!
        if Reachability.isConnectedToNetwork() {
            Loader.start()
            print(num)
            getData(num: num, pass: pass)
        } else {
        }
       
    }
    
    func getData (num:String,pass:String) {
        API.getLogin(number: num, password: passTf.text!) { data in
            Loader.stop()
            
            print("data11=",num == data.phoneNumber)
            if num != "" ,pass != "" {
                if num == data.phoneNumber, pass == data.password {
                    SetCache.saveCache(for: data.token, for: KeysDM.token)
                    SetCache.saveCache(for: data._id, for: KeysDM.id)
                    self.navigationController?.pushViewController(HomeVC.loadFromNib(), animated: true)
                } else {
                    self.showErrorAlert(title: "Error", message: "Malumot kiritishda xatolik bor yoki bunday foydalanuvchi mavjud emas")
                    
                }
            }else {
                self.showErrorAlert(title: "Error", message: "iltimos raqam yoki passwordni kiriting")
            }
        }
    }
    
    
}



extension String{
    func createRangeinaLink(of findWord: String) -> NSRange {
        let range = (self as NSString) .range(of: findWord, options: .caseInsensitive)
        return range
    }
}
