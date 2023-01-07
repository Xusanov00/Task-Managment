//
//  AppDelegate.swift
//  Task_Managment
//
//  Created by Chingiz Jumanov on 06/01/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        if #available(iOS 13.0, *) {
                    window!.overrideUserInterfaceStyle = .light
                }
        let navvc = UINavigationController(rootViewController: TaskVC.loadFromNib())
        window?.rootViewController = navvc
        window?.makeKeyAndVisible()
        return true
    }
}


