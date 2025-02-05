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
        button.backgroundColor = UIColor(named: "LightBlue")
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 0.3
        button.layer.masksToBounds = false
        return button
    }()
    
    // default background
    private let placeholder: UIView = {
        let view = UIView()
        return view
    }()
    
    
    private let defaultImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "map_bckgrnd")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowRadius = 5
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.masksToBounds = false
        return imageView
    }()
    
    // stack
    private let verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fill
        stack.backgroundColor = .white
        stack.layer.cornerRadius = 20
        stack.layer.shadowColor = UIColor.black.cgColor
        stack.layer.shadowRadius = 5
        stack.layer.shadowOpacity = 0.5
        stack.layer.masksToBounds = false
        return stack
    }()
    
    private let horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .leading
        return stack
    }()
    
    // text
    let cardText: UILabel = {
        let label = UILabel()
        label.text = "Template"
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    let sepLine: UIView = {
        let line = UIView()
        line.backgroundColor = .gray
        return line
    }()
    
    // map view
    
    // weather view
    
    // cryptocurrency view
    

    func setupView() {
        self.addSubview(verticalStack)
        verticalStack.widthToSuperview(multiplier: 0.9) // под сомнением,можно придумать как убрать
        verticalStack.centerInSuperview()
        verticalStack.addArrangedSubview(horizontalStack)
        verticalStack.addArrangedSubview(sepLine)
        verticalStack.addArrangedSubview(placeholder)
        horizontalStack.addArrangedSubview(cardText)
        placeholder.widthToSuperview()
        placeholder.addSubview(defaultImage)
        placeholder.addSubview(choiceButton)
        placeholder.addSubview(settingsButton)
        defaultImage.centerInSuperview()
        settingsButton.topToSuperview(offset: 40)
        settingsButton.rightToSuperview(offset: -40)
        choiceButton.edgesToSuperview(insets: TinyEdgeInsets(top: 140, left: 120, bottom: 40, right: 120))
        cardText.leftToSuperview(offset: 20)
        cardText.topToSuperview(offset: 5)
        sepLine.widthToSuperview()
        sepLine.heightToSuperview(multiplier: 0.005)
    }
}
