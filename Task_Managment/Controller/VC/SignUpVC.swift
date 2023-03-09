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
    
    //outlets
    @IBOutlet weak var signUpLbl: UILabel!
    @IBOutlet weak var signUpDescryptLbl: UILabel!
    @IBOutlet weak var numberTF: PhoneNumberTextField!
    @IBOutlet weak var passwordTF: UIView!
    @IBOutlet weak var privasyLbl: UITextView!
    @IBOutlet weak var passTf: PasswordTextField!
    @IBOutlet weak var internetLottieV: UIView!
    @IBOutlet weak var continueBtn: UIButton!
    
    //variables
    let message = Lang.getString(type: .privacyPolicyDescrypt)
    let findWord = [Lang.getString(type: .termsUse), Lang.getString(type: .privacyPolicy)]
    //    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLang()
        setTextField()
        privacyPolicyLabel()
        continueBtn.addShadow(cornerRadius: 12)
        setUpNav()
    }
    
    //MARK: - Set Up Navigation
    func setUpNav() {
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    //MARK: Privacy Policy Label Text Attributes
    func privacyPolicyLabel() {
        let attributeMutableStringLink = NSMutableAttributedString(string: message)
        attributeMutableStringLink.addAttribute(.link, value: "https://www.google.co.in/", range:
                                                    message.createRangeinaLink(of: findWord[0]))
        attributeMutableStringLink.addAttribute(.link, value: "https://www.youtube.com/", range:
                                                    message.createRangeinaLink(of: findWord[1]))
        privasyLbl.attributedText = attributeMutableStringLink
    }
    
    
    //MARK: Language Settings
    func setLang() {
        signUpLbl.text = Lang.getString(type: .signIn)
        signUpDescryptLbl.text = Lang.getString(type: .signipVCDesc)
        continueBtn.setTitle(Lang.getString(type: .continu), for: .normal)
        passTf.placeholder = Lang.getString(type: .password)
    }
    
    //MARK: Number textField
    func setTextField() {
        numberTF.defaultRegion = "UZ"
        numberTF.backgroundColor = .white
        numberTF.withFlag = true
        numberTF.withExamplePlaceholder = true
        numberTF.addShadow(cornerRadius: 12)
        passwordTF.addShadow(cornerRadius: 12)
    }
    
    //MARK: Actions
    @IBAction func continueTapped(_ sender: UIButton)
    
}


//MARK: - Sending Number of User to BackEnd
extension SignUpVC {
    func getData (num:String,pass:String) {
        API.getLogin(number: num, password: passTf.text!) { data in
            
            if num != "" ,pass != "" {
                if num == data.phoneNumber, pass == data.password {
                    SetCache.saveCache(for: data.token, for: KeysDM.token)
                    SetCache.saveCache(for: data._id, for: KeysDM.id)
                    self.navigationController?.pushViewController(HomeVC.loadFromNib(), animated: true)
                } else {
                    self.showErrorAlert(title: Lang.getString(type: .alertError), message: Lang.getString(type: .alertNumbError))
                }
            }else {
                self.showErrorAlert(title: Lang.getString(type: .alertError), message: Lang.getString(type: .alertEnterNumb))
            }
        }
    }
}


//MARK: - Create Range in a Link
extension String {
    func createRangeinaLink(of findWord: String) -> NSRange {
        let range = (self as NSString) .range(of: findWord, options: .caseInsensitive)
        return range
    }
}


//MARK: - NnotificationCenter for language changing
extension SignUpVC {
    func observeLangNotif() {
        NotificationCenter.default.addObserver(self, selector: #selector(changLang), name: NSNotification.Name.init(rawValue: "LANGNOTIFICATION"), object: nil)
        print("NotificationCenter SignUpVC")
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
