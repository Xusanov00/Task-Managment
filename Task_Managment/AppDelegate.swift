//
//  AppDelegate.swift
//  Task_Managment
//
//  Created by Chingiz Jumanov on 06/01/23.
//

import UIKit
import IQKeyboardManagerSwift
import GoogleMaps
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        IQKeyboardManager.shared.enable = true
        GMSServices.provideAPIKey("AIzaSyDyIYU9ntbMg5ZEDHnLmCaQWnISnVj5kB4")
        if #available(iOS 13.0, *) {
            window!.overrideUserInterfaceStyle = .light
        }
        
        var navvc = UINavigationController(rootViewController: HomeVC.loadFromNib())
//        if SetCache.getCache(for: KeysDM.token.rawValue).isEmpty {
             navvc = UINavigationController(rootViewController: StartVC.loadFromNib())
//        }
        window?.rootViewController = navvc
        window?.makeKeyAndVisible()
        return true
    }
}


