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
        
        // Создаём окно
        window = UIWindow(frame: UIScreen.main.bounds)
        // Назначаем главный экран
        window?.rootViewController = ViewController()
        // Делаем окно видимым
        window?.makeKeyAndVisible()

        return true
    }


}

