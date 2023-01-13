//
//  TaskVC.swift
//  Task_Managment
//
//  Created by Ali on 07/01/23.
//

import UIKit
import FSCalendar

class TaskVC: UIViewController {
    
    //outlets
    @IBOutlet weak var calendarV: UIView!
    @IBOutlet weak var taskTablView: UITableView!
    fileprivate weak var calendar: FSCalendar!
    
    //variables
    var taskArr: [TaskDM] = [ ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTaskTablView()
        setCalendar()
    }
    
    
    //MARK: - Set Up TableView
    func setTaskTablView() {
        taskTablView.separatorStyle = .none
        taskTablView.dataSource = self
        taskTablView.register(TaskTVC.nib(), forCellReuseIdentifier: TaskTVC.id)
    }
}


//MARK: - UITableViewDataSource
extension TaskVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = taskTablView.dequeueReusableCell(withIdentifier: TaskTVC.id, for: indexPath) as? TaskTVC else {return UITableViewCell()}
        cell.updateCell(cell: taskArr[indexPath.row])
        return cell
    }
    
    
}



//MARK: - FSCalendarDataSource, FSCalendarDelegate
extension TaskVC: FSCalendarDataSource, FSCalendarDelegate {
    
    func setCalendar() {
        
        let calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 32, height: 280))
        calendar.dataSource = self
        calendar.delegate = self
        calendarV.addSubview(calendar)
        
        self.calendar = calendar
    }
}
