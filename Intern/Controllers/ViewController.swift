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
        let card = Card(frame: UIScreen.main.bounds)
        let stack = CardStack(frame: UIScreen.main.bounds)
        view.addSubview(stack)
        stack.edgesToSuperview(usingSafeArea: true)
        stack.setupView()
    }
}


