//
//  Ex+UIWindow.swift
//  Task_Managment
//
//  Created by Chingiz Jumanov on 09/01/23.
//

import UIKit

extension UIWindow {
    static var keyWindow: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
