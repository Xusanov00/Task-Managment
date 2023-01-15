//
//  connectionLottie.swift
//  Task_Managment
//
//  Created by Ali on 12/01/23.
//

import Foundation
import SnapKit
import Lottie

class ConnectionLottie {
    private static var animationView: LottieAnimationView!
    class func setUpAnimationView(lottie: String, view: UIView, button: UIButton? = nil) {
        view.isHidden = false
        animationView = .init(name: lottie)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 2
        view.addSubview(animationView)
        animationView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        animationView.stop()
        button?.isEnabled = false
        button?.layer.opacity = 0.8
        animationView.play()
        _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { _ in
            animationView.stop()
                view.isHidden = true
//                animationView.isHidden = true
            button?.layer.opacity = 1
            button?.isEnabled = true
        })
    }
    
    
}
