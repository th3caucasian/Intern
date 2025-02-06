//
//  AppDelegate.swift
//  Intern
//
//  Created by Алан Эркенов on 04.02.2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = TableViewController()
        window?.makeKeyAndVisible()
        return true
    }


}

