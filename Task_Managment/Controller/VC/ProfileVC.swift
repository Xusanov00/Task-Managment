//
//  ProfileVC.swift
//  TaskManagement
//
//  Created by Chingiz Jumanov on 05/01/23.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var fullnameLbl: UILabel!
    @IBOutlet weak var numberLbl: UILabel!
    @IBOutlet var statusVs: [UIView]!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var completedLbl: UILabel!
    @IBOutlet weak var inProgressLbl: UILabel!
    @IBOutlet weak var toDoLbl: UILabel!
    
    @IBOutlet weak var completedCountLbl: UILabel!
    @IBOutlet weak var inProgressCountLbl: UILabel!
    @IBOutlet weak var toDoCountLbl: UILabel!
    
    
    
    
    var userData: UserDM?
    
    let settingsArr: [SettingsDM] = [
        SettingsDM(img: "person", title: Lang.getString(type: .editProf)),
        SettingsDM(img: "flag", title: Lang.getString(type: .changeLang)),
        SettingsDM(img: "doc.text", title: Lang.getString(type: .tasks)),
        SettingsDM(img: "chart.xyaxis.line", title: Lang.getString(type: .statistics)),
        SettingsDM(img: "bell", title: Lang.getString(type: .notifications)),
        SettingsDM(img: "checkmark.shield", title: Lang.getString(type: .security)),
        SettingsDM(img: "exclamationmark.circle", title: Lang.getString(type: .help)),
        SettingsDM(img: "door.right.hand.open", title: Lang.getString(type: .logout), tintColor: .systemRed, titleColor: .systemRed)
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNav()
        setLang()
        setUpTableView()
        setUserData()
        self.navigationController?.navigationBar.tintColor = .black
        observeLangNotif()
    }
    
    
    
    //MARK: localizated languages
    func setLang() {
        completedLbl.text = Lang.getString(type: .completed)
        inProgressLbl.text = Lang.getString(type: .inProgress)
        toDoLbl.text = Lang.getString(type: .toDo)
        print("til o'zgardi------------")
    }
    
    func setUserData() {
        guard let userData = userData else { return }
        fullnameLbl.text = userData.lastName + " " + userData.firstName
        numberLbl.text = userData.phoneNumber
        completedCountLbl.text = "\(userData.stats.completed)"
        inProgressCountLbl.text = "\(userData.stats.progress)"
        toDoCountLbl.text = "\(userData.stats.unCompleted)"
        
    }
    
    func setUpTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingsTVC.nib(), forCellReuseIdentifier: SettingsTVC.identifier)
        
        
    }
    
    func setUpNav() {
        self.navigationItem.backBarButtonItem?.image = UIImage(systemName: "chevron.left")
        self.navigationItem.title = Lang.getString(type: .profile)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        let alertBtn = UIBarButtonItem(image: UIImage(systemName: "bell.badge"), style: .done, target: self, action: #selector(alertTapped))
        
        alertBtn.tintColor = .black
        self.navigationItem.backButtonTitle = Lang.getString(type: .profile)
        self.navigationItem.rightBarButtonItems = [alertBtn]
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        self.navigationItem.rightBarButtonItem?.tintColor = .black
        
        for v in statusVs {
            v.addShadow(cornerRadius: 12)
        }
        
    }
    
    @objc func alertTapped() {
        let vc = ChatsVC.loadFromNib()
        vc.navigationItem.backButtonTitle = ""
        
        navigationController?.pushViewController(ChatsVC.loadFromNib(), animated: true)
    }
    
}

//MARK: - UITableViewDelegate
extension ProfileVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var index = 0
        if indexPath.section == 0 {
            index = indexPath.row
        }else {
            index = indexPath.row+3
        }
        
        
        
        switch index {
        case 0:
            let vc = EditProfileVC.loadFromNib()
            vc.userData = userData
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = ChangeLangVC.loadFromNib()
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = TaskVC.loadFromNib()
            navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = StatisticsVC.loadFromNib()
            navigationController?.pushViewController(vc, animated: true)
        default:
            let vc = StartVC.loadFromNib()
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
}

//MARK: - UITableViewDataSource
extension ProfileVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else {
            return 4
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTVC.identifier, for: indexPath) as? SettingsTVC else { return UITableViewCell() }
        if indexPath.section == 0 {
            cell.updateCell(data: settingsArr[indexPath.row])
        } else {
            cell.updateCell(data: settingsArr[indexPath.row+3])
        }
        return cell
    }
}



//MARK: - NnotificationCenter for language changing
extension ProfileVC {
    func observeLangNotif() {
        NotificationCenter.default.addObserver(self, selector: #selector(changLang), name: NSNotification.Name.init(rawValue: "LANGNOTIFICATION"), object: nil)
        print("NotificationCenter ProfileVC")
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
