//
//  GetTVC.swift
//  Task_Managment
//
//  Created by MacBook Pro on 07/01/23.
//

import UIKit

class GetTVC: UITableViewCell {
    @IBOutlet weak var backV: UIView!
    @IBOutlet weak var messageLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateCell(str:String) {
        messageLbl.text = str
    }
    
}
