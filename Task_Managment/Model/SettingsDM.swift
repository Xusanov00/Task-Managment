//
//  SettingsDM.swift
//  TaskManagement
//
//  Created by Chingiz Jumanov on 05/01/23.
//

import UIKit

struct SettingsDM {
    
    var img: String
    var title: String
    var tintColor: UIColor = #colorLiteral(red: 0.3947566152, green: 0.4917233586, blue: 0.938395977, alpha: 1)
    var titleColor: UIColor = .black
    
    var image: UIImage {
        UIImage(systemName: img)!
    }
}
