//
//  Ex+UIView.swift
//  TaskManagement
//
//  Created by Chingiz Jumanov on 05/01/23.
//

import UIKit

@IBDesignable extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
              layer.cornerRadius = newValue

              // If masksToBounds is true, subviews will be
              // clipped to the rounded corners.
              layer.masksToBounds = (newValue > 0)
        }
    }
}


@IBDesignable extension UIView {
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let cgColor = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: cgColor)
        }
        set { layer.borderColor = newValue?.cgColor }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    ///set shadow to view
    func addShadow() {
            layer.masksToBounds = false
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.2
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowRadius = 5
            layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 12).cgPath
            layer.shouldRasterize = true
            layer.rasterizationScale = UIScreen.main.scale
        }
}




