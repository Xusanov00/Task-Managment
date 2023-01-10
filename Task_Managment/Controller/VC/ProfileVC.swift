//
//  ProfileVC.swift
//  TaskManagement
//
//  Created by Chingiz Jumanov on 05/01/23.
//

import UIKit

class ProfileVC: UIViewController {
    
    
    @IBOutlet var statusVs: [UIView]!
    
    @IBOutlet weak var tableView: UITableView!
    
    let settingsArr: [SettingsDM] = [
        SettingsDM(img: "person", title: "Edit Profile"),
        SettingsDM(img: "doc.text", title: "Tasks"),
        SettingsDM(img: "chart.xyaxis.line", title: "Statistics"),
        SettingsDM(img: "bell", title: "Notifications"),
        SettingsDM(img: "checkmark.shield", title: "Security"),
        SettingsDM(img: "exclamationmark.circle", title: "Help"),
        SettingsDM(img: "trash", title: "Logout", tintColor: .systemRed, titleColor: .systemRed)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNav()
        setUpTableView()
        self.navigationController?.navigationBar.tintColor = .black
        
    }

    
    func setUpTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingsTVC.nib(), forCellReuseIdentifier: SettingsTVC.identifier)
        
        
    }
    
    func setUpNav() {
        self.navigationItem.backBarButtonItem?.image = UIImage(systemName: "chevron.left")
        self.navigationItem.title = "Profile"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        let alertBtn = UIBarButtonItem(image: UIImage(systemName: "bell.badge"), style: .done, target: self, action: #selector(alertTapped))
        
        alertBtn.tintColor = .black
        self.navigationItem.backButtonTitle = ""
        self.navigationItem.rightBarButtonItems = [alertBtn]
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        self.navigationItem.rightBarButtonItem?.tintColor = .black
        
        for v in statusVs {
            v.addShadow(cornerRadius: 12)
        }
        
    }
    
    @objc func alertTapped() {
        let vc = ChatsVC(nibName: "ChatsVC", bundle: nil)
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
        
        var vc = UIViewController()
        
        switch index {
        case 0:
            vc = EditProfileVC.loadFromNib()
        case 1:
            vc = TaskVC.loadFromNib()
        case 2:
            vc = StatisticsVC.loadFromNib()
        default:
            vc = StartVC.loadFromNib()
        }
        if vc != UIViewController() {
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

