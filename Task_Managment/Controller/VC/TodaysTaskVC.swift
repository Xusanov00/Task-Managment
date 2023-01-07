//
//  TodaysTaskVC.swift
//  TaskManagement
//
//  Created by MacBook Pro on 05/01/23.
//

import UIKit

class TodaysTaskVC: UIViewController {
    
    @IBOutlet var btns: [UIButton]!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backV: UIView!
    @IBOutlet weak var taskTableView: UITableView!
    var num = 0
    var taskArr: [TaskDM] = [
        TaskDM(topic: "Topic1", definition: "Definition1", time: "12:00 - 18-00", priority: "Completed"),
        TaskDM(topic: "Topic2", definition: "Definition2", time: "12:00 - 18-00", priority: "In Progress"),
        TaskDM(topic: "Topic3", definition: "Definition3", time: "12:00 - 18-00", priority: "To Do"),
        TaskDM(topic: "Topic4", definition: "Definition4", time: "12:00 - 18-00", priority: "Completed"),
        TaskDM(topic: "Topic5", definition: "Definition5", time: "12:00 - 18-00", priority: "To Do"),
        TaskDM(topic: "Topic6", definition: "Definition6", time: "12:00 - 18-00", priority: "In Progress"),
        TaskDM(topic: "Topic7", definition: "Definition7", time: "12:00 - 18-00", priority: "Completed"),
        TaskDM(topic: "Topic8", definition: "Definition8", time: "12:00 - 18-00", priority: "To Do"),
    ]
    var sortedTasks: [TaskDM] = []
    
    var weeks:[String] = ["Du","Se","Chor","Pay","Ju","Shan","Yak"]
    
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "Today’s task"
        self.navigationController?.navigationBar.tintColor = .black
        backV.isHidden = true
        setUpNavigationV()
        setupTableView()
        setUpCollectionView()
        setBackColor(tag: 0)
    }
    
    func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        collectionView.register(UINib(nibName: "DayCVC", bundle: nil), forCellWithReuseIdentifier: "DayCVC")
    }
    
    
    
    
    func setupTableView() {
        taskTableView.dataSource = self
        taskTableView.separatorStyle = .none
        taskTableView.register(UINib(nibName: "TaskTVC", bundle: nil), forCellReuseIdentifier: "TaskTVC")
        
    }
    
    
    
    
    
    @IBAction func btnTapped(_ sender: UIButton) {
        setBackColor(tag: sender.tag)
        num = sender.tag
        taskTableView.reloadData()
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationItem.backButtonTitle = ""
        self.navigationController?.navigationBar.tintColor = .black
        navigationController?.pushViewController(StartTaskVC.loadFromNib(), animated: true)
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
            sortedTasks = taskArr.filter { $0.priority == "In Progress" }
        case 2:
            sortedTasks.removeAll()
            sortedTasks = taskArr.filter { $0.priority == "Completed" }
        case 3:
            sortedTasks.removeAll()
            sortedTasks = taskArr.filter { $0.priority == "To Do" }
            
        default:
            print("")
        }
        return sortedTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = taskTableView.dequeueReusableCell(withIdentifier: "TaskTVC", for: indexPath) as? TaskTVC else {return UITableViewCell()}
        
        
        switch num {
        case 0:
            sortedTasks.removeAll()
            sortedTasks = taskArr
        case 1:
            sortedTasks.removeAll()
            sortedTasks = taskArr.filter { $0.priority == "In Progress" }
        case 2:
            sortedTasks.removeAll()
            sortedTasks = taskArr.filter { $0.priority == "Completed" }
        case 3:
            sortedTasks.removeAll()
            sortedTasks = taskArr.filter { $0.priority == "To Do" }
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
        cell.addShadow(cornerRadius: 10)
        cell.updateCell(weekdays: weeks[indexPath.item])
        return cell
    }
}


//MARK: - UICollectionViewDelegate
extension TodaysTaskVC:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 2*(collectionView.frame.width - 50)/11, height: collectionView.frame.height-20)
        
    }
}
