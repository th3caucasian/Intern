//
//  ViewController.swift
//  Intern
//
//  Created by Алан Эркенов on 04.02.2025.
//

import UIKit
import TinyConstraints

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        setupNavigationBar()
        
        let card = Card(frame: UIScreen.main.bounds)
        let stack = CardStack(frame: UIScreen.main.bounds)
        view.addSubview(stack)
        stack.edgesToSuperview(insets: TinyEdgeInsets(top: 30, left: 0, bottom: 30, right: 0), usingSafeArea: true)
        stack.setupView()
        

    }
    
    func setupNavigationBar() {
        self.title = "Главный экран"
        if let navigationBar = self.navigationController?.navigationBar {
            if #available(iOS 13.0, *) {
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
            else {
                navigationBar.tintColor = .white
                navigationBar.backgroundColor = .lightBlue
                navigationBar.titleTextAttributes = [
                    .font: UIFont.systemFont(ofSize: 22, weight: .semibold),
                    .foregroundColor: UIColor.white
                ]
            }
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(buttonEditPressed))
    }
    
    
    @objc func buttonEditPressed() {
        let settings = SettingsController()
        self.navigationController?.pushViewController(settings, animated: true)
    }
}


