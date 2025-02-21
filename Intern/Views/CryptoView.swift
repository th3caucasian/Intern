//
//  CryptoCard.swift
//  Intern
//
//  Created by Алан Эркенов on 08.02.2025.
//

import UIKit
import Kingfisher

class CryptoView: UIView {
    
    private let cryptoName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    private let cryptoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let cryptoPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.contentMode = .scaleAspectFit
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private var priceDynamic: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.contentMode = .scaleAspectFit
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let arrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    func fillData(cryptoName: String, cryptoImage: String, cryptoPrice: String, priceDynamic: String) {
        self.cryptoName.text = cryptoName
        self.cryptoImage.kf.setImage(with: URL(string: cryptoImage))
        self.cryptoPrice.text = cryptoPrice
        self.priceDynamic.text = priceDynamic
        if (priceDynamic.first == "-") {
            self.priceDynamic.textColor = .red
            self.arrowImage.tintColor = .red
            self.arrowImage.image = UIImage(systemName: "arrow.down")
        } else {
            self.priceDynamic.textColor = .systemGreen
            self.priceDynamic.text = "+" + priceDynamic
            self.arrowImage.tintColor = .systemGreen
            self.arrowImage.image = UIImage(systemName: "arrow.up")
        }
        setupView()
    }
    
    func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 20
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 2)
        translatesAutoresizingMaskIntoConstraints = false
        
        [cryptoName, cryptoImage, cryptoPrice, horizontalStack].forEach(addSubview(_:))
        [priceDynamic, arrowImage].forEach(horizontalStack.addArrangedSubview(_:))

        
        cryptoName.widthToSuperview(multiplier: 0.9)
        cryptoName.centerXToSuperview()
        cryptoName.topToSuperview(offset: 20)
        
        cryptoImage.topToBottom(of: cryptoName, offset: 10)
        cryptoImage.widthToSuperview(multiplier: 0.9)
        cryptoImage.centerXToSuperview()
        cryptoImage.height(70)
        
        cryptoPrice.widthToSuperview(multiplier: 0.9)
        cryptoPrice.centerXToSuperview()
        cryptoPrice.topToBottom(of: cryptoImage, offset: 10)
        
        arrowImage.height(15)
        
        horizontalStack.topToBottom(of: cryptoPrice, offset: 4)
        horizontalStack.centerXToSuperview()

    }
}
