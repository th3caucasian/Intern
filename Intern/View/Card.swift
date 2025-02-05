//
//  Card.swift
//  Intern
//
//  Created by Алан Эркенов on 04.02.2025.
//

import UIKit
import TinyConstraints

class Card: UIView {
    
    private var choice = false
    private let viewWidth: CGFloat = 370
    private let viewHeight: CGFloat = 230
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // settings button
    private let settingsButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "settings")
        button.setImage(image, for: .normal)
        return button
    }()
    
    // choice button
    private let choiceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Выбрать", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.backgroundColor = UIColor(named: "LightBlue")
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        return button
    }()
    
    // default background
    private let defaultBackground: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.178, green: 0.600, blue: 0.902, alpha: 0.2)
        view.layer.cornerRadius = 20
        return view
    }()
    
    // stack
    private let verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fill
        stack.spacing = 5
        return stack
    }()
    
    // text
    var cardText: UILabel = {
        let label = UILabel()
        label.text = "Template"
        return label
    }()
    
    
    // map view
    
    // weather view
    
    // cryptocurrency view
    

    func setupView() {
        self.addSubview(verticalStack)
        verticalStack.edgesToSuperview()
        verticalStack.addArrangedSubview(cardText)
        verticalStack.addArrangedSubview(defaultBackground)
        defaultBackground.widthToSuperview()
        defaultBackground.addSubview(choiceButton)
        defaultBackground.addSubview(settingsButton)
        settingsButton.topToSuperview(offset: 10)
        settingsButton.rightToSuperview(offset: -10)
        choiceButton.edgesToSuperview(insets: TinyEdgeInsets(top: 120, left: 105, bottom: 30, right: 105))
    }
}
