//
//  CryptoCard.swift
//  Intern
//
//  Created by Алан Эркенов on 17.02.2025.
//

import UIKit
import Foundation

class CryptoCard: Card {
    private let horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 8
        return stack
    }()

    
    override func setupView() {
        super.setupView()
        cardText.text = ^"crypto_card_title"
        defaultImage.image = UIImage(named: "crypto_bckgrnd")
        errorView.setTitle(^"crypto_card_error", for: .normal)
        cardType = .crypto
        startLoading()
    }
    
    
    // Вызывается при установке списка криптовалюты
    func setCrypto(cryptos: [Crypto]?) {
        var cryptoViews: [CryptoView] = []
        if (choice == false) {
            choice = true
            loadingView.stopAnimating()
            [choiceButton, defaultImage].forEach {$0.isHidden = true}
            placeholder.addSubview(horizontalStack)
            horizontalStack.edgesToSuperview()
        }
        if var cryptoList = cryptos {
            if (cryptoList.isEmpty) {
                choice = false
                [choiceButton, defaultImage].forEach {$0.isHidden = false}
                [errorView, horizontalStack].forEach {$0.isHidden = true}
                return
            }
            cryptoList = cryptoList.sorted { $0.id < $1.id }
            errorView.isHidden = true
            horizontalStack.isHidden = false
            horizontalStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
            let leftSpacer: UIView = UIView()
            let rightSpacer: UIView = UIView()
            [leftSpacer, rightSpacer].forEach { horizontalStack.addArrangedSubview($0) }
            for i in cryptoList.indices {
                cryptoViews.append(CryptoView())
                let crypto = cryptoList[i]
                let dynamic = crypto.current_price / 100 * crypto.price_change_percentage_1h_in_currency
                cryptoViews[i].fillData(cryptoName: crypto.id, cryptoImage: crypto.image, cryptoPrice: String(crypto.current_price) + " $", priceDynamic: String(format: "%.4f", dynamic))
                horizontalStack.insertArrangedSubview(cryptoViews[i], at: horizontalStack.arrangedSubviews.count - 1)
                cryptoViews[i].widthToSuperview(multiplier: 0.3)
                cryptoViews[i].heightToSuperview(multiplier: 0.9)
            }
        } else {
            loadingView.stopAnimating()
            [choiceButton, defaultImage, horizontalStack].forEach { $0.isHidden = true }
            errorView.isHidden = false
        }
    }
}
