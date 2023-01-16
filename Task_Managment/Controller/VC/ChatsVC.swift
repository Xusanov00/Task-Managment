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
import AVFoundation

class ChatsVC: UIViewController {
    
    //outlets
    @IBOutlet weak var backV:UIView!
    @IBOutlet weak var textTf:UITextField!
    @IBOutlet weak var sendBtn:UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyChatImg: UIImageView!
    @IBOutlet weak var noSmsLbl: UILabel!
    
    //variables
    var screenSize = UIScreen.main.bounds
    
    var sendArr:[String] = []
    var myConstraint_DefualtValue = CGFloat(30)
    
    var player: AVAudioPlayer?
    var indexPath: IndexPath?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        getComments()
        setLang()
    }
    
    
    //MARK: language settings
    func setLang(){
        noSmsLbl.text = Lang.getString(type: .noSms)
        title = Lang.getString(type: .comment)
        textTf.placeholder = Lang.getString(type: .enterSms)
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
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        
        self.view.addGestureRecognizer (UITapGestureRecognizer(target: self, action: #selector (hideKeyboard)))
        
        if sendArr.count == 0 {
            tableView.backgroundColor = .clear
        }
    }
    
    
    //MARK: empty chat image set
    func setImg() {
        if !sendArr.isEmpty {
            emptyChatImg.isHidden = true
            noSmsLbl.isHidden = true
        }else {
            emptyChatImg.isHidden = false
            noSmsLbl.isHidden = false
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
        playSendSound()
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


//MARK: - Send Sound
extension ChatsVC {
    func playSendSound() {
        let soundURL = Bundle.main.url(forResource: "SendMessage", withExtension: "mp3")
        
        do {
            try player = AVAudioPlayer(contentsOf: soundURL!)
        } catch {
            print(error)
        }
        player?.play()
    }
}


//MARK: - NnotificationCenter for language changing
extension ChatsVC {
    func observeLangNotif() {
        NotificationCenter.default.addObserver(self, selector: #selector(changLang), name: NSNotification.Name.init(rawValue: "LANGNOTIFICATION"), object: nil)
        print("NotificationCenter ChatsVC")
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
