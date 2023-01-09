//
//  TaskVC.swift
//  Task_Managment
//
//  Created by Ali on 07/01/23.
//

import UIKit
import FSCalendar

class TaskVC: UIViewController {
    
    
    @IBOutlet weak var calendarV: UIView!
    
    @IBOutlet weak var taskTablView: UITableView!
    
    fileprivate weak var calendar: FSCalendar!
    var taskArr: [TaskDM] = [
        TaskDM(topic: "Competitive Analysis", definition: "This productive tool is designed productive...", time: "12:00 - 18-00", priority: "Completed"),
        TaskDM(topic: "Competitive Analysis", definition: "This productive tool is designed productive...", time: "12:00 - 18-00", priority: "In Progress"),
        TaskDM(topic: "Competitive Analysis", definition: "This productive tool is designed productive...", time: "12:00 - 18-00", priority: "To Do"),
        TaskDM(topic: "Competitive Analysis", definition: "This productive tool is designed productive...", time: "12:00 - 18-00", priority: "Completed"),
        TaskDM(topic: "Competitive Analysis", definition: "This productive tool is designed productive...", time: "12:00 - 18-00", priority: "To Do"),
        TaskDM(topic: "Competitive Analysis", definition: "This productive tool is designed productive...", time: "12:00 - 18-00", priority: "In Progress"),
        TaskDM(topic: "Competitive Analysis", definition: "This productive tool is designed productive...", time: "12:00 - 18-00", priority: "Completed"),
        TaskDM(topic: "Competitive Analysis", definition: "This productive tool is designed productive...", time: "12:00 - 18-00", priority: "To Do"),
    ]
    
//    var taskArr = ["Complation",
//                   "In Progress",
//                   "Complation",
//                   "In Progress",
//                   "Complation",
//                   "To Do", "Complation",
//                   "Complation", "To Do"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTaskTablView()
        setCalendar()
    }
    
    
    //task tableView settings
    func setTaskTablView() {
        taskTablView.separatorStyle = .none
        taskTablView.dataSource = self
        taskTablView.register(TaskTVC.nib(), forCellReuseIdentifier: TaskTVC.id)
    }
    
    
}



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


extension TaskVC: FSCalendarDataSource, FSCalendarDelegate {
    
    func setCalendar() {
        
        let calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 32, height: 280))
        calendar.dataSource = self
        calendar.delegate = self
        calendarV.addSubview(calendar)
        
        self.calendar = calendar
    }
}
