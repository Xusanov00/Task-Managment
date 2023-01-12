//
//  SettingsTVC.swift
//  TaskManagement
//
//  Created by Chingiz Jumanov on 05/01/23.
//

import UIKit

class SettingsTVC: UITableViewCell {

    @IBOutlet weak var iconImg: UIImageView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var chevronImg: UIImageView!
    
    static func nib() -> UINib {
        UINib(nibName: "SettingsTVC", bundle: nil)
    }
    static let identifier = "SettingsTVC"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }
    
    func updateCell(data: SettingsDM) {
        iconImg.image = data.image
        iconImg.tintColor = data.tintColor
        titleLbl.text = data.title.localized()
        titleLbl.textColor = data.titleColor
        if data.title == "Logout" {
            chevronImg.alpha = 0
        }
    }
}
