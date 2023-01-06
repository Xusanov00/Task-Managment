//
//  TodaysTaskVC.swift
//  TaskManagement
//
//  Created by MacBook Pro on 05/01/23.
//

import UIKit

class TodaysTaskVC: UIViewController {

    @IBOutlet var btns: [UIButton]!
    
    @IBOutlet weak var tableView: UITableView!
    var num = 0
    var str = ["Complation","In Progress","Complation","In Progress","Complation","To Do", "Complation", "Complation", "To Do"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "Today’s task"
        self.navigationController?.navigationBar.tintColor = .black
        
        setUpNavigationV()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        tableView.register(UINib(nibName: "TaskTVC", bundle: nil), forCellReuseIdentifier: "TaskTVC")
        
    }
    
    
    
    
    
    @IBAction func btnTapped(_ sender: UIButton) {
        setBackColor(tag: sender.tag)
         num = sender.tag
        tableView.reloadData()
    }
    
    
    func setUpNavigationV () {
        let notificBtn = UIBarButtonItem(image: UIImage(systemName: "bell.badge"), style: .done, target: self, action: #selector(notificTapped))
        self.navigationItem.rightBarButtonItem = notificBtn
        self.navigationItem.rightBarButtonItem?.tintColor = .black
        self.navigationItem.leftBarButtonItem?.tintColor = .black
    }
    @objc func notificTapped() {
        
    }
    
    
    func setBackColor(tag:Int) {
        for i  in btns {
            i.backgroundColor = .clear
            i.setTitleColor(.gray, for: .normal)
        }
        
        btns[tag].backgroundColor = #colorLiteral(red: 0.324398458, green: 0.3902252913, blue: 0.9221590161, alpha: 1)
        btns[tag].setTitleColor(.white, for: .normal)
    }

}
//MARK: - UITableViewDelegate
extension TodaysTaskVC:UITableViewDelegate {
    
}
//MARK: - UITableViewDataSource
extension TodaysTaskVC:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        str.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTVC", for: indexPath) as? TaskTVC else {return UITableViewCell()}
        cell.updateCell(str: str[indexPath.row])
        
        if self.num == 1 {
            if str[indexPath.row] == "Complation" {
                return cell
            }
        } else  if self.num == 2 {
            if str[indexPath.row] == "In Progress" {
                return cell
            }
        }else if self.num == 3 {
            if str[indexPath.row] == "To Do" {
                return cell
            }
        }
        return cell
    }
}
