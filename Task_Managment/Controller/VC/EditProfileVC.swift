//
//  EditProfileVC.swift
//  Task_Managment
//
//  Created by Chingiz Jumanov on 06/01/23.
//

import UIKit

class EditProfileVC: UIViewController {
    
    @IBOutlet weak var camV: UIImageView!
    
    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet var tfViews: [UIView]!
    
    @IBOutlet weak var saveBtn: UIButton!
    
    @IBOutlet weak var birthdateTextField: UITextField!
    
    @IBOutlet weak var phoneNumberTf: UITextField!
    
    @IBOutlet weak var fullNameLbl: UILabel!
    
    @IBOutlet weak var phoneNumberLbl: UILabel!
    
    @IBOutlet weak var nameTf: UITextField!
    
    @IBOutlet weak var lastnameTf: UITextField!
    
    
    
    var userData: UserDM?
    
    let datePicker = UIDatePicker()
    var birth = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingShadowViewsAndBtns()
        setDatePicker()
        setUI()
    }
    
    
    func setUI() {
        self.navigationItem.title = "Profile Edit"
        guard let data = userData else { return }
        phoneNumberTf.text = data.phoneNumber
        nameTf.text = data.firstName
        lastnameTf.text = data.lastName
        fullNameLbl.text = data.lastName + " " + data.firstName
        
        
        
        
        
    }
    
    
    func settingShadowViewsAndBtns() {
        for v in tfViews {
            v.addShadow(cornerRadius: 12)
        }
        camV.addShadow(cornerRadius: 18)
        saveBtn.addShadow(cornerRadius: 12)
    }
    
    func setDatePicker() {
        //Format Date
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        } else {
            // Fallback on earlier versions
        }
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneDatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        birthdateTextField.inputAccessoryView = toolbar
        birthdateTextField.inputView = datePicker
    }
    
    @objc func doneDatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        birth = formatter.string(from: datePicker.date)
        birthdateTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    
    @IBAction func calendarTapped(_ sender: UIButton) {
        birthdateTextField.becomeFirstResponder()
    }
    
    @IBAction func changeTapped(_ sender: UIButton) {
        
        
        
        
        
        
        //MARK: - Formatter text
//        guard let text = phoneNumberTf.text else { return }
//        phoneNumberTf.text = text.applyPatternOnNumbers(pattern: "+### ## ### ## ##", replacementCharacter: "#")
    }
    
    
    @IBAction func saveTapped(_ sender: Any) {
        API.updateProfile(name: nameTf.text!, lastname: lastnameTf.text!, position: "NodeJS Developer", password: "123456") { [self] data in
            updateUser(isUpdated: true)
        }
        
    }

}


//MARK: - NotificationCenter
extension EditProfileVC {
    func updateUser(isUpdated: Bool) {
        NotificationCenter.default.post(name: NSNotification.Name.init("UPDATEUSER"), object: isUpdated)
    }
}
