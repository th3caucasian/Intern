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
        view.backgroundColor = .white
        let card = Card(frame: UIScreen.main.bounds)
        let stack = CardStack(frame: UIScreen.main.bounds)
        
        // Добавляем кнопку на экран
        view.addSubview(card)
        card.widthToSuperview(offset: -25)
        card.heightToSuperview(multiplier: 0.25)
        card.centerInSuperview()
        card.setupView()
    }
}


