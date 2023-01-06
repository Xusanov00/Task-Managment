//
//  Ex+UIViewController.swift
//  TaskManagement
//
//  Created by Chingiz Jumanov on 05/01/23.
//

import UIKit

extension UIViewController {
    
    ///VC from Nib
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        return instantiateFromNib()
    }
}
