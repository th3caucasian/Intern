//
//  SetupManager.swift
//  Intern
//
//  Created by Алан Эркенов on 23.02.2025.
//

import UIKit

class SetupManager {
    static func setupNavigationBar(_ navigationController: UINavigationController?) {
        if let navigationBar = navigationController?.navigationBar {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .lightBlue
            appearance.titleTextAttributes = [
                .font: UIFont.systemFont(ofSize: 22, weight: .semibold),
                .foregroundColor: UIColor.white
            ]
            navigationBar.scrollEdgeAppearance = appearance
            navigationBar.standardAppearance = appearance
            navigationBar.compactAppearance = appearance
            navigationBar.tintColor = .white

        }
    }
}
