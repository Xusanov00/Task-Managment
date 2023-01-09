//
//  SendTVC.swift
//  Task_Managment
//
//  Created by MacBook Pro on 07/01/23.
//

import UIKit

class SendTVC: UITableViewCell {

    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var backV: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func UpdateCell(str:String) {
        messageLbl.text = str
    }
    
    
}
