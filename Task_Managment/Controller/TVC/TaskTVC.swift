//
//  TaskTVC.swift
//  TaskManagement
//
//  Created by MacBook Pro on 05/01/23.
//

import UIKit

class TaskTVC: UITableViewCell {
    @IBOutlet weak var backV: UIView!
    @IBOutlet weak var priorityLbl: UILabel!
    
    @IBOutlet weak var shadowV: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func updateCell(str:String) {
        priorityLbl.text = str
        if priorityLbl.text == "Complation" {
            backV.backgroundColor = #colorLiteral(red: 0.9281279445, green: 0.9780753255, blue: 0.9470465779, alpha: 1)
            priorityLbl.textColor = #colorLiteral(red: 0.2781714797, green: 0.7590492368, blue: 0.4490745068, alpha: 1)
        } else if priorityLbl.text == "In Progress" {
            backV.backgroundColor = #colorLiteral(red: 0.9998732209, green: 0.9553380609, blue: 0.8955518603, alpha: 1)
            priorityLbl.textColor = #colorLiteral(red: 1, green: 0.540979445, blue: 0.0009590052068, alpha: 1)
        } else if priorityLbl.text == "To Do" {
            backV.backgroundColor = #colorLiteral(red: 0.921910584, green: 0.941830337, blue: 0.9972619414, alpha: 1)
            priorityLbl.textColor = #colorLiteral(red: 0.2226326466, green: 0.4325051904, blue: 0.9460671544, alpha: 1)
        } else {
            backV.backgroundColor = .green
            priorityLbl.textColor = .red
        }
    }
    
    
}
