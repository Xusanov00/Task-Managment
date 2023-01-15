//
//  DayCVC.swift
//  Task_Managment
//
//  Created by MacBook Pro on 07/01/23.
//

import UIKit

class DayCVC: UICollectionViewCell {

    @IBOutlet weak var backV: UIView!
    @IBOutlet weak var weeks: UILabel!
    @IBOutlet weak var icobV: UIView!
    @IBOutlet weak var monthDays: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func updateCell(weekdays:WeekDM) {
        weeks.text = String(weekdays.day.prefix(3))
        monthDays.text = String((weekdays.time).suffix(2))
    }
    
    
}
