//
//  ChatsVC.swift
//  Task_Managment
//
//  Created by MacBook Pro on 07/01/23.
//

import UIKit
import IQKeyboardManagerSwift

class ChatsVC: UIViewController {
    
    var screenSize = UIScreen.main.bounds
    
    
    
    
    
    @IBOutlet weak var backV:UIView!
    @IBOutlet weak var textTf:UITextField!
    @IBOutlet weak var sendBtn:UIButton!
    @IBOutlet weak var tableView: UITableView!
    var sendArr:[String] = []
    var myConstraint_DefualtValue = CGFloat(30)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer (UITapGestureRecognizer(target: self, action: #selector (hideKeyboard)))
        IQKeyboardManager.shared.disabledToolbarClasses = false
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
       didload()
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as?
            NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            let backVSpace = self.view.frame.height - (backV.frame.origin.y + backV.frame.height)
            self.backV.frame.origin.y -= keyboardHeight - backVSpace
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.backV.frame.origin.y = backV.frame.origin.y
//        if self.backV.frame.origin.y != self.view.frame.height - backV.frame.height {
//            self.backV.frame.origin.y = self.view.frame.height - backV.frame.height
//        }
    }
    @objc private func hideKeyboard() {
    self.view.endEditing (true)
    }
    
    
    
    
    
    func didload() {
        self.navigationItem.title = "Comment"
        textTf.layer.cornerRadius = 12
        sendBtn.layer.cornerRadius = sendBtn.frame.width/2
        backV.addShadow(cornerRadius: 0)
        textTf.addShadow(cornerRadius: 12)
        sendBtn.addShadow(cornerRadius: sendBtn.frame.width/2)
        setUpTableView()
        IQKeyboardManager.shared.enable = false
        
        if sendArr.count == 0 {
            tableView.isHidden = true
        }
       
    }
    
    
    
    
    
    
    


    
    
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "GetTVC", bundle: nil), forCellReuseIdentifier: "GetTVC")
        tableView.register(UINib(nibName: "SendTVC", bundle: nil), forCellReuseIdentifier: "SendTVC")
        
        
    }
    
 
    
    
    @IBAction func sendTapped(_ sender: UIButton) {
        tableView.isHidden = false
        if textTf.text! != "" {
            sendArr.append(textTf.text!)
            
            DispatchQueue.main.async {
                    let indexPath = IndexPath(row: self.sendArr.count-1, section: 0)
                    self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                }
            tableView.reloadData()
            textTf.text = ""
        }
    }

}








extension ChatsVC:UITableViewDelegate {
    

    
    
}
extension ChatsVC:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sendArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        guard let getcell = tableView.dequeueReusableCell(withIdentifier: "GetTVC", for: indexPath) as? GetTVC else {return UITableViewCell()}
        guard let sendcell = tableView.dequeueReusableCell(withIdentifier: "SendTVC", for: indexPath) as? SendTVC else {return UITableViewCell()}
        sendcell.UpdateCell(str: sendArr[indexPath.row])
        return sendcell
    }
}
