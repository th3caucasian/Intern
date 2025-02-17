//
//  Card.swift
//  Intern
//
//  Created by Алан Эркенов on 04.02.2025.
//

import UIKit
import TinyConstraints

// Вью одной карточки
class Card: UIView {
    
    var choice = false
    weak var buttonsHandlerDelegate: ButtonsHandlerDelegate?
    weak var networkDelegate: NetworkDelegate?
    

    let settingsButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "settings")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let choiceButton: UIButton = {
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
    
    let placeholder: UIView = {
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
    
    
    private let upperPlaceholder: UIView = {
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
    
    
    private let sepLine: UIView = {
        let line = UIView()
        line.backgroundColor = .systemGray4
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    
    let errorView: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue.withAlphaComponent(0.2)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 20
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    
    let loadingView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()

    func setupView(_ buttonsHandlerDelegate: ButtonsHandlerDelegate?, _ networkDelegate: NetworkDelegate?) {
        self.buttonsHandlerDelegate = buttonsHandlerDelegate
        self.networkDelegate = networkDelegate
        
        self.addSubview(verticalStack)
        verticalStack.widthToSuperview(multiplier: 0.9)
        verticalStack.centerInSuperview()
        verticalStack.addArrangedSubview(upperPlaceholder)
        verticalStack.addArrangedSubview(sepLine)
        verticalStack.addArrangedSubview(placeholder)
        
        upperPlaceholder.addSubview(cardText)
        upperPlaceholder.addSubview(settingsButton)
        upperPlaceholder.widthToSuperview()
        upperPlaceholder.heightToSuperview(multiplier: 0.15)
        
        placeholder.widthToSuperview()
        placeholder.addSubview(defaultImage)
        placeholder.addSubview(choiceButton)
        placeholder.addSubview(errorView)

        defaultImage.centerInSuperview()
        defaultImage.widthToSuperview(offset: -30)
        
        settingsButton.topToSuperview(offset: 6)
        settingsButton.rightToSuperview(offset: -10)
        
        choiceButton.edgesToSuperview(insets: TinyEdgeInsets(top: 130, left: 100, bottom: 30, right: 100))
        
        cardText.leftToSuperview(offset: 20)
        cardText.topToSuperview(offset: 7)
        
        sepLine.widthToSuperview()
        sepLine.heightToSuperview(multiplier: 0.005)
        
        errorView.edgesToSuperview(insets: TinyEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        errorView.isHidden = true
        
    }
    
}
