//
//  TodaysTaskVC.swift
//  TaskManagement
//
//  Created by MacBook Pro on 05/01/23.
//

import UIKit
import FSCalendar
class TodaysTaskVC: UIViewController {

    //outlets
    @IBOutlet var btns: [UIButton]!
    @IBOutlet weak var stackV:UIStackView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backV:UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    //variables
    var calendar:FSCalendar!
    var num = 0
    var taskArr: [TaskDM] = [ ]
    var sortedTasks: [TaskDM] = []
    
    var weeks:[WeekDM] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "Today’s task"
        self.navigationController?.navigationBar.tintColor = .black
        getWeekendlyStatus(day: 1673548155)
        setUpNavigationV()
        getTodaysTask()
        
    }
    func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        collectionView.register(UINib(nibName: "DayCVC", bundle: nil), forCellWithReuseIdentifier: "DayCVC")
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
        let vc = ChatsVC(nibName: "ChatsVC", bundle: nil)
        vc.navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(ChatsVC.loadFromNib(), animated: true)
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
extension TodaysTaskVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationItem.backButtonTitle = ""
        let vc = StartTaskVC.loadFromNib()
        vc.task = sortedTasks[indexPath.row]
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


//MARK: - UITableViewDataSource
extension TodaysTaskVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch num {
        case 0:
            sortedTasks.removeAll()
            sortedTasks = taskArr
        case 1:
            sortedTasks.removeAll()
            sortedTasks = taskArr.filter { $0.priority == "progress" }
        case 2:
            sortedTasks.removeAll()
            sortedTasks = taskArr.filter { $0.priority == "completed" }
        case 3:
            sortedTasks.removeAll()
            sortedTasks = taskArr.filter { $0.priority == "pending" }
            
        default:
            print("")
        }
        return sortedTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "TaskTVC", for: indexPath) as? TaskTVC else {return UITableViewCell()}
        
        
        switch num {
        case 0:
            sortedTasks.removeAll()
            sortedTasks = taskArr
        case 1:
            sortedTasks.removeAll()
            sortedTasks = taskArr.filter { $0.priority == "progress" }
        case 2:
            sortedTasks.removeAll()
            sortedTasks = taskArr.filter { $0.priority == "completed" }
        case 3:
            sortedTasks.removeAll()
            sortedTasks = taskArr.filter { $0.priority == "pending" }
        default:
            print("")
        }
        
        cell.updateCell(cell: sortedTasks[indexPath.row])
        return cell
        
    }
    
    
}

//MARK: - UICollectionViewDataSource
extension TodaysTaskVC:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        weeks.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCVC", for: indexPath) as? DayCVC else {return UICollectionViewCell()}
        cell.updateCell(weekdays: weeks[indexPath.item])
        if indexPath.item == 0 {
            cell.backV.backgroundColor = #colorLiteral(red: 0.324398458, green: 0.3902252913, blue: 0.9221590161, alpha: 1)
            cell.icobV.backgroundColor = #colorLiteral(red: 0.324398458, green: 0.3902252913, blue: 0.9221590161, alpha: 1)
            cell.weeks.textColor = .white
            cell.monthDays.textColor = .white
        } else{
            cell.backV.addShadow(cornerRadius: 10)
            
        }
        return cell
    }
}


//MARK: - UICollectionViewDelegate
extension TodaysTaskVC:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 2*(collectionView.frame.width - 50)/11, height: collectionView.frame.height-20)
        
    }
}




//MARK: - getTodaysTask
extension TodaysTaskVC {
    func getTodaysTask() {
        API.getTodaysTask(day: 1673690400) { data in
            
            self.taskArr = data
            self.setupTableView()
            
        }
    }
    
    func getWeekendlyStatus(day:Int) {
        API.getWeekendlyStatus(userId: cache.string(forKey: KeysDM.id.rawValue) ?? "ID", day: day) { data in
            self.weeks = data
            self.setUpCollectionView()
        }
    }
    
    
    
}
