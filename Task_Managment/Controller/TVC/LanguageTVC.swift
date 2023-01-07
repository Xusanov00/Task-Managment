//
//  LanguageTVC.swift
//  Task_Managment
//
//  Created by Ali on 06/01/23.
//

import UIKit

class LanguageTVC: UITableViewCell {
    
    static func nib() -> UINib {
        UINib(nibName: "LanguageTVC", bundle: nil)
    };static let id = "LanguageTVC"
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var flagImg: UIImageView!
    @IBOutlet weak var languageLbl: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //updates cell details
    func updateCell(cell: LanguageDM) {
        cellView.addShadow(cornerRadius: 12)
        flagImg.image = UIImage(named: cell.image)
        languageLbl.text = cell.language
    }
    
}
