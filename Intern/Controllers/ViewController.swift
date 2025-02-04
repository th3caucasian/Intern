//
//  ViewController.swift
//  Intern
//
//  Created by Алан Эркенов on 04.02.2025.
//

import UIKit
import TinyConstraints

class ViewController: UIViewController {
    
    // Создаём кнопку
    let myButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Нажми меня", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Добавляем кнопку на экран
        view.addSubview(myButton)
        
        // Устанавливаем ограничения
        myButton.translatesAutoresizingMaskIntoConstraints = false
        myButton.centerInSuperview()
        myButton.width(20)
        myButton.height(300)
    }
}


