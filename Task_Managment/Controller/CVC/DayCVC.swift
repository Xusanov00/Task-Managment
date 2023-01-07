//
//  DayCVC.swift
//  Task_Managment
//
//  Created by MacBook Pro on 07/01/23.
//

import UIKit

class DayCVC: UICollectionViewCell {

    @IBOutlet weak var weeks: UILabel!
    @IBOutlet weak var monthDays: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func updateCell(weekdays:String) {
        weeks.text = weekdays
    }
    
    
}
