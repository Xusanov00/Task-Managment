//
//  TaskTVC.swift
//  TaskManagement
//
//  Created by MacBook Pro on 05/01/23.
//

import UIKit

class TaskTVC: UITableViewCell {
    
    static func nib() -> UINib {
        UINib(nibName: "TaskTVC", bundle: nil)
    };static let id = "TaskTVC"
    
    
    
    @IBOutlet weak var topicLbl: UILabel!
 
    @IBOutlet weak var descryptionLbl: UILabel!
    
    @IBOutlet weak var timeLbl: UILabel!
    
    @IBOutlet weak var priorityView: UIView!
    
    @IBOutlet weak var priorityLbl: UILabel!
    
    
    @IBOutlet weak var shadowV: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    
    func updateCell(cell: TaskDM) {
        shadowV.addShadow(cornerRadius: 12)
        topicLbl.text = cell.title
        descryptionLbl.text = cell.definition
        timeLbl.text = "\(cell.time)"
        
        if cell.priority.uppercased() == "COMPLETED" {
            priorityLbl.text = Lang.getString(type: .completed)
            priorityView.backgroundColor = #colorLiteral(red: 0.2784313725, green: 0.7607843137, blue: 0.4470588235, alpha: 0.1)
            priorityLbl.textColor = #colorLiteral(red: 0.2784313725, green: 0.7607843137, blue: 0.4470588235, alpha: 1)
        } else if cell.priority.uppercased() == "PROGRESS" {
            priorityLbl.text = Lang.getString(type: .inProgress)
            priorityView.backgroundColor = #colorLiteral(red: 1, green: 0.5411764706, blue: 0, alpha: 0.1)
            priorityLbl.textColor = #colorLiteral(red: 1, green: 0.5411764706, blue: 0, alpha: 1)
        } else if cell.priority.uppercased() == "PENDING" {
            priorityLbl.text = Lang.getString(type: .toDo)
            priorityView.backgroundColor = #colorLiteral(red: 0.2235294118, green: 0.431372549, blue: 0.9450980392, alpha: 0.1)
            priorityLbl.textColor = #colorLiteral(red: 0.2235294118, green: 0.431372549, blue: 0.9450980392, alpha: 1)
        } else {
            priorityView.backgroundColor = .green
            priorityLbl.textColor = .red
        }
    }
    
    
}


