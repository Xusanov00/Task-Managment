//
//  EndTaskVC.swift
//  Task_Managment
//
//  Created by Chingiz Jumanov on 07/01/23.
//

import UIKit
import CircleProgressView
class EndTaskVC: UIViewController {

    
    @IBOutlet weak var timerView: CircleProgressView!
    
    @IBOutlet weak var timerLbl: UILabel!
    
    @IBOutlet weak var commentTv: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNav()
        settingTextView()
    }

    
    
    func setUpNav() {
        self.navigationItem.backButtonTitle = ""
        let alertBtn = UIBarButtonItem(image: UIImage(systemName: "bell.badge"), style: .done, target: self, action: #selector(alertTapped))
       
        alertBtn.tintColor = .black
        
        
        self.navigationItem.rightBarButtonItems = [alertBtn]
    }
    
    @objc func alertTapped() {
        let vc = ChatsVC(nibName: "ChatsVC", bundle: nil)
        vc.navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(ChatsVC.loadFromNib(), animated: true)
    }
    
    
    func settingTextView() {
        commentTv.delegate = self
        commentTv.text = "Write comment"
        commentTv.textColor = UIColor.lightGray
        commentTv.addShadow(cornerRadius: 4)
    }
    
}

//MARK: - UITextViewDelegate
extension EndTaskVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Write Comment"
            textView.textColor = UIColor.lightGray
        }
    }
    
}
