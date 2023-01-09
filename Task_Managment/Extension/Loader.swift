//
//  Loader.swift
//  Task_Managment
//
//  Created by MacBook Pro on 09/01/23.
//

import Foundation
import UIKit
import Lottie

public class Loader {
    
    //Shows custom Alert for awhile
    
    class func start() {
        
        let load = UIView ()
        
        load.tag = 2002
        
        load.backgroundColor = .clear
        
        load.frame = UIScreen.main.bounds
        
        let customView = LottieAnimationView()
        
        customView.frame = CGRect (x: 0, y: 0, width: 70, height: 70)
        
        customView.clipsToBounds = true
        
        customView.layer.cornerRadius = 20
        
        load.addSubview(customView)
        
        customView.translatesAutoresizingMaskIntoConstraints=false; customView.centerXAnchor.constraint(equalTo:load.centerXAnchor).isActive=true
        
        customView.centerYAnchor.constraint (equalTo: load.centerYAnchor).isActive = true
        
        customView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        customView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        customView.backgroundColor = .systemGray6
        
        UIApplication.shared.keyWindow?.addSubview(load)
        
        customView.animation = LottieAnimation.named("pulse" )
        
        customView.animationSpeed = 1.2
        
        customView.loopMode = . loop
        
        customView.play()
        
    }
    
    class func stop() {
        
        for i in UIApplication.shared.keyWindow!.subviews {
            
            if i.tag == 2002 {
                
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
                    
                    i.alpha = 0
                    
                } completion: { _ in
                    
                    i.removeFromSuperview()
                    
                }
                
            }
            
        }
        
    }
    
}
