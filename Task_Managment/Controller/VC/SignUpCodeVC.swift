//
//  SignUpCodeVC.swift
//  TaskManagement
//
//  Created by Ali on 05/01/23.
//

import UIKit
import OTPFieldView
import SnapKit


class SignUpCodeVC: UIViewController {
    
    @IBOutlet weak var tfView: OTPFieldView!
    @IBOutlet weak var numberLbl: UILabel!
    
    @IBOutlet weak var timerLbl: UILabel!
    var numberStr = ""
    @IBOutlet weak var codeResendBtn: UIButton!
    @IBOutlet weak var lineView: UIView!
    var timer = Timer()
    var seconds = 4
    var isTimerRunning = false
    var otpIsCorrect = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOtpView()
        numberLbl.text = numberStr
        runTimer()
    }
    
    //MARK: set textFieldView
    func setupOtpView(){
        tfView.backgroundColor = .white
        tfView.fieldsCount = 4
        tfView.defaultBorderColor = UIColor.systemGray5
        tfView.filledBorderColor = UIColor.systemGray5
        tfView.cursorColor = UIColor.systemBlue
        tfView.displayType = .roundedCorner
        tfView.fieldBorderWidth = 3
        tfView.fieldSize = 48
        tfView.separatorSpace = 10
        tfView.layer.shadowColor = UIColor.red.cgColor
        tfView.shouldAllowIntermediateEditing = true
        tfView.delegate = self
        tfView.initializeUI()
        
    }
    
    func runTimer() {
        codeResendBtn.isEnabled = false
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTimer() {
        seconds -= 1
        lineView.snp.makeConstraints { make in
            make.width.height.equalTo((codeResendBtn.currentTitle?.count ?? 18)*4)
        }
        if seconds >= 0 {
            
            codeResendBtn.isEnabled = false
            timerLbl.text = "Enter the code (\(seconds))"
        }else {
            codeResendBtn.isEnabled = true
            timerLbl.text = "Resend"
        }
    }
    
    @IBAction func codeResendTapped(_ sender: Any) {
        print("Resending")
    }
    
    
    @IBAction func VerifyTapped(_ sender: UIButton) {
        enteredOTP(otp: "")
        if otpIsCorrect {
            print("Verified")
        }else {
            print("otp uncorrect")
            tfView.errorBorderColor = .red
        }
    }
    
    
                                     
}


extension SignUpCodeVC: OTPFieldViewDelegate {
    func hasEnteredAllOTP(hasEnteredAll hasEntered: Bool) -> Bool {
        print("Has entered all OTP? \(hasEntered)")
        return false
    }
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        
        return true
    }
    
    func enteredOTP(otp otpString: String) {
        print("yes")
        print("OTPString: \(otpString)")
        if otpString.count == 4 /*, otpString == "sms code"*/ {
            otpIsCorrect = true
        }else {
            otpIsCorrect = false
        }
        
    }
}

