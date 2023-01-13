//
//  ChatsVC.swift
//  Task_Managment
//
//  Created by MacBook Pro on 07/01/23.
//

import UIKit
import IQKeyboardManagerSwift
import Alamofire
import SwiftyJSON

class ChatsVC: UIViewController {
    
    //outlets
    @IBOutlet weak var backV:UIView!
    @IBOutlet weak var textTf:UITextField!
    @IBOutlet weak var sendBtn:UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyChatImg: UIImageView!
    
    //variables
    var screenSize = UIScreen.main.bounds
  
    var sendArr:[String] = []
    var myConstraint_DefualtValue = CGFloat(30)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        getComments()
    }
    
    
    
    //MARK: - will show keyboard
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as?
            NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            let backVSpace = self.view.frame.height - (backV.frame.origin.y + backV.frame.height)
            self.backV.frame = CGRect(x: 0, y: CGFloat(Int(backV.frame.origin.y + 10 - keyboardHeight)), width: self.backV.frame.width, height: self.backV.frame.height)
        }
    }
    
    //MARK: - will hide keyboard
    @objc func keyboardWillHide(notification: NSNotification) {
        self.backV.frame = CGRect(x: 0, y: CGFloat(Int(self.view.frame.height - backV.frame.height - 100)), width: self.backV.frame.width, height: self.backV.frame.height)
    }
    
    //MARK: -  hide keyboard
    @objc private func hideKeyboard() {
    self.view.endEditing (true)
    }
    
    //MARK: - Set UP UI
    func setUpUI() {
        self.navigationItem.title = "Comment"
        textTf.layer.cornerRadius = 12
        sendBtn.layer.cornerRadius = sendBtn.frame.width/2
        backV.addShadow(cornerRadius: 0)
        textTf.addShadow(cornerRadius: 12)
        sendBtn.addShadow(cornerRadius: sendBtn.frame.width/2)
        setUpTableView()
        IQKeyboardManager.shared.enable = false
        IQKeyboardManager.shared.enableAutoToolbar = false
        self.view.addGestureRecognizer (UITapGestureRecognizer(target: self, action: #selector (hideKeyboard)))
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        if sendArr.count == 0 {
            tableView.backgroundColor = .clear
        }
    }
    
 
    //MARK: empty chat image set
    func setImg() {
        if !sendArr.isEmpty {
            emptyChatImg.isHidden = true
        }else {
            emptyChatImg.isHidden = false
        }
    }
    
    //MARK: - Set Up TableView
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "GetTVC", bundle: nil), forCellReuseIdentifier: "GetTVC")
        tableView.register(UINib(nibName: "SendTVC", bundle: nil), forCellReuseIdentifier: "SendTVC")
    }
        
    //MARK: - Actions
    @IBAction func sendTapped(_ sender: UIButton) {
        tableView.backgroundColor = .white
        if textTf.text! != "" {
            sendArr.append(textTf.text!)
            getCommentToTask(taskID: "63b82310464c9232856ccd1c", commentTxt: textTf.text!)
            DispatchQueue.main.async {
                    let indexPath = IndexPath(row: self.sendArr.count-1, section: 0)
                    self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                }
            setImg()
            tableView.reloadData()
            textTf.text = ""
        }
    }

}

//MARK: - UITableViewDelegate
extension ChatsVC:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let deleteAction = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive, state: .off) { [self]_ in
                        
            sendArr.remove(at: indexPath.row)
            tableView.reloadData()
            
        }
                
        let menu = UIMenu(title: "Delete of Comment", options: .displayInline, children: [deleteAction])
        
        let contextmenu = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            
            return menu
            
        }
        
        return contextmenu
        
    }
    
}


//MARK: - UITableViewDataSource
extension ChatsVC:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sendArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sendcell = tableView.dequeueReusableCell(withIdentifier: "SendTVC", for: indexPath) as? SendTVC else {return UITableViewCell()}
        sendcell.UpdateCell(str: sendArr[indexPath.row])
        sendcell.backV.addShadow(cornerRadius: 12)
        return sendcell
    }
}


//MARK: - Get Comment To Task
extension ChatsVC {
    func getCommentToTask(taskID: String, commentTxt: String) {
        API.getCommentTask(taskID: taskID, textComment: commentTxt) { data in
            print(data.text)
        }
    }
}


//MARK: - Get Comments
extension ChatsVC {
    func getComments() {
        API.getComments(taskID: "63b82310464c9232856ccd1c") { data in
            self.sendArr = data
            self.setImg()
            self.tableView.reloadData()
            Loader.stop()
        }
    }
}


