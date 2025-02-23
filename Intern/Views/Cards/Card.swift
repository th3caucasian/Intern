//
//  Card.swift
//  Intern
//
//  Created by Алан Эркенов on 04.02.2025.
//

import UIKit
import TinyConstraints

enum CardType: String, Codable {
    case unknown = ""
    case city = "city_card_title"
    case weather = "weather_card_title"
    case crypto = "crypto_card_title"
}

enum Action {
    case selectPressed
    case reloadPressed
}

// Вью одной карточки
class Card: UIView {
    
    var choice = false
    var cardType = CardType.unknown
    var handleAction: ((Action) -> Void)?
    
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
        label.font = UIFont.systemFont(ofSize: 17.scaleValue())
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
    
    
    func setupView() {

        addSubview(verticalStack)
        verticalStack.edgesToSuperview(insets: TinyEdgeInsets(top: 0, left: 15, bottom: 0, right: 15))
        [upperPlaceholder, sepLine, placeholder].forEach {verticalStack.addArrangedSubview($0)}

        [cardText, settingsButton].forEach {upperPlaceholder.addSubview($0)}
        upperPlaceholder.widthToSuperview()
        upperPlaceholder.heightToSuperview(multiplier: 0.15)
        
        placeholder.widthToSuperview()
        [defaultImage, choiceButton, errorView, loadingView].forEach {placeholder.addSubview($0)}
        
        defaultImage.edgesToSuperview(insets: TinyEdgeInsets(top: 6, left: 15, bottom: 6, right: 15))
        
        settingsButton.edgesToSuperview(excluding: [.bottom, .left], insets: TinyEdgeInsets(top: 6, left: 0, bottom: 0, right: 10))
        settingsButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        settingsButton.size(CGSize(width: 25.scaleValue(), height: 25.scaleValue()))
        
        choiceButton.width(170.scaleValue())
        choiceButton.height(40.scaleValue())
        choiceButton.centerXToSuperview()
        choiceButton.bottomToSuperview(offset: -40)
        choiceButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        cardText.edgesToSuperview(excluding: [.bottom, .right], insets: TinyEdgeInsets(top: 7, left: 20, bottom: 0, right: 0))
        
        sepLine.widthToSuperview()
        sepLine.heightToSuperview(multiplier: 0.005)
        
        errorView.edgesToSuperview(insets: TinyEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        errorView.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        errorView.isHidden = true
        loadingView.centerInSuperview()
        loadingView.isHidden = true
    }
    
    // Метод отображающий вьюшку загрузки
    func startLoading() {
        loadingView.isHidden = false
        [defaultImage, choiceButton, errorView].forEach {$0.isHidden = true}
        loadingView.startAnimating()
    }
    
    func stopLoading() {
        loadingView.stopAnimating()
        [defaultImage, choiceButton].forEach {$0.isHidden = false}
    }
    
    // Передача типа нажатой кнопки в обработчик
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case choiceButton:
            fallthrough
        case settingsButton:
            handleAction?(.selectPressed)
        case errorView:
            startLoading()
            handleAction?(.reloadPressed)
        default:
            print("Функция была вызвана из неожиданного состояния")
        }

    }
}
