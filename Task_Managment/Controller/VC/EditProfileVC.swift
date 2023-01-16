//
//  EditProfileVC.swift
//  Task_Managment
//
//  Created by Chingiz Jumanov on 06/01/23.
//

import UIKit

class EditProfileVC: UIViewController {
    
    
    // outlets
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
    
    //variables
    var userData: UserDM?
    let datePicker = UIDatePicker()
    var birth = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingShadowViewsAndBtns()
        setDatePicker()
        setUI()
        setUpGesture()
    }
    
    
    //MARK: language settings
    func setLang() {
        nameTf.placeholder = Lang.getString(type: .name)
        lastnameTf.placeholder = Lang.getString(type: .surname)
        birthdateTextField.placeholder = Lang.getString(type: .dateBirth)
        phoneNumberTf.placeholder = Lang.getString(type: .number)
        saveBtn.setTitle(Lang.getString(type: .save), for: .normal)
    }
    
    //MARK: - Get Image from Gallery
    func setImageFromGallery() {
        let imgVC = UIImagePickerController()
        imgVC.delegate = self
        imgVC.sourceType = .savedPhotosAlbum
        imgVC.allowsEditing = true
        profileImg.contentMode = .scaleAspectFill
        self.present (imgVC, animated: true)
    }
    
    
    //MARK: - Set Up Gesture to ImageView
    func setUpGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        profileImg.isUserInteractionEnabled = true
        profileImg.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        setImageFromGallery()
    }
    
    
    //MARK: - Set Up UI
    func setUI() {
        self.navigationItem.title = "Profile Edit"
        guard let data = userData else { return }
        phoneNumberTf.text = data.phoneNumber
        nameTf.text = data.firstName
        lastnameTf.text = data.lastName
        fullNameLbl.text = data.lastName + " " + data.firstName
    }
    
    
    //MARK: - Set Up Shadow
    func settingShadowViewsAndBtns() {
        for v in tfViews {
            v.addShadow(cornerRadius: 12)
        }
        camV.addShadow(cornerRadius: 18)
        saveBtn.addShadow(cornerRadius: 12)
    }
    
    
    //MARK: - Set DatePicker to keyboard
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
    
    
    
    //MARK: - Actions
    @IBAction func calendarTapped(_ sender: UIButton) {
        birthdateTextField.becomeFirstResponder()
    }
    
}


//MARK: - NotificationCenter
extension EditProfileVC {
    func updateUser(isUpdated: Bool) {
        NotificationCenter.default.post(name: NSNotification.Name.init("UPDATEUSER"), object: isUpdated)
    }
}


//MARK: - UIImagePickerControllerDelegate, UIPopoverControllerDelegate, UINavigationControllerDelegate
extension EditProfileVC: UIImagePickerControllerDelegate,UIPopoverControllerDelegate,UINavigationControllerDelegate  {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let editedImg = info[.editedImage] as? UIImage
        self.profileImg.image = editedImg
        self.dismiss(animated: true)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
}



//MARK: - NnotificationCenter for language changing
extension EditProfileVC {
    func observeLangNotif() {
        NotificationCenter.default.addObserver(self, selector: #selector(changLang), name: NSNotification.Name.init(rawValue: "LANGNOTIFICATION"), object: nil)
        print("NotificationCenter EditProfileVC")
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
