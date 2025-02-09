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
        return label
    }()
    
    private var priceDynamic: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.contentMode = .scaleAspectFit
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let arrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        }
        else {
            self.priceDynamic.textColor = .systemGreen
            self.priceDynamic.text = "+" + self.priceDynamic.text!
            self.arrowImage.tintColor = .systemGreen
            self.arrowImage.image = UIImage(systemName: "arrow.up")
        }
        setupView()
    }
    
    func setupView() {
        self.addSubview(cryptoName)
        self.addSubview(cryptoImage)
        self.addSubview(cryptoPrice)
        self.addSubview(priceDynamic)
        self.addSubview(arrowImage)
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        cryptoName.widthToSuperview(multiplier: 0.9)
        cryptoName.centerXToSuperview(offset: 0)
        cryptoName.topToSuperview(offset: 20)
        
        cryptoImage.topToBottom(of: cryptoName, offset: 10)
        cryptoImage.widthToSuperview(multiplier: 0.9)
        cryptoImage.centerXToSuperview(offset: 0)
        cryptoImage.height(70)
        
        cryptoPrice.widthToSuperview(multiplier: 0.9)
        cryptoPrice.centerXToSuperview(offset: 0)
        cryptoPrice.topToBottom(of: cryptoImage, offset: 10)
        
        priceDynamic.widthToSuperview(multiplier: 0.9)
        priceDynamic.centerXToSuperview(offset: 0)
        priceDynamic.topToBottom(of: cryptoPrice, offset: 5)
        
        arrowImage.height(15)
        arrowImage.leftToRight(of: priceDynamic, offset: 2)
        arrowImage.topToBottom(of: cryptoPrice, offset: 4)
    }
}
