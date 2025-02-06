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

    private let settingsButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "settings")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let choiceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Выбрать", for: .normal)
        button.backgroundColor = UIColor(named: "LightBlue")
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 1
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 0.15
        button.layer.masksToBounds = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let placeholder: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let defaultImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "map_bckgrnd")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    

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
        stack.layer.shadowOffset = CGSize(width: 0, height: 2)
        stack.layer.masksToBounds = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let placeholder2: UIView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let cardText: UILabel = {
        let label = UILabel()
        label.text = "Template"
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let sepLine: UIView = {
        let line = UIView()
        line.backgroundColor = .systemGray4
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    // map view
    
    // weather view
    
    // cryptocurrency view
    

    func setupView() {
        self.addSubview(verticalStack)
        verticalStack.widthToSuperview(multiplier: 0.9) // под сомнением,можно придумать как убрать
        verticalStack.centerInSuperview()
        verticalStack.addArrangedSubview(placeholder2)
        verticalStack.addArrangedSubview(sepLine)
        verticalStack.addArrangedSubview(placeholder)
        
        placeholder2.addSubview(cardText)
        placeholder2.addSubview(settingsButton)
        placeholder2.widthToSuperview()
        placeholder2.heightToSuperview(multiplier: 0.15)
        
        placeholder.widthToSuperview()
        placeholder.addSubview(defaultImage)
        placeholder.addSubview(choiceButton)
        
        defaultImage.centerInSuperview()
        defaultImage.widthToSuperview(offset: -30)
        
        settingsButton.topToSuperview(offset: 6)
        settingsButton.rightToSuperview(offset: -10)
        
        choiceButton.edgesToSuperview(insets: TinyEdgeInsets(top: 130, left: 100, bottom: 30, right: 100))
        
        cardText.leftToSuperview(offset: 20)
        cardText.topToSuperview(offset: 7)
        
        sepLine.widthToSuperview()
        sepLine.heightToSuperview(multiplier: 0.005)
    }
}
