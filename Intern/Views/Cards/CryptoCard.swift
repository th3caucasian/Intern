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

    
    override func setupView(_ buttonsHandlerDelegate: ButtonsHandlerDelegate?, _ networkDelegate: NetworkDelegate?) {
        super.setupView(buttonsHandlerDelegate, networkDelegate)
        
        choiceButton.addTarget(self, action: #selector(delegateCryptoPressed), for: .touchUpInside)
        settingsButton.addTarget(self, action: #selector(delegateCryptoPressed), for: .touchUpInside)
        cardText.text = "Курс криптовалют"
        defaultImage.image = UIImage(named: "crypto_bckgrnd")
        placeholder.addSubview(loadingView)
        loadingView.centerInSuperview()
        loadingView.isHidden = true
        errorView.addTarget(self, action: #selector(reloadCrypto), for: .touchUpInside)
        errorView.setTitle("При загрузке произошла ошибка", for: .normal)
        if let cryptoList = UserDefaults.standard.data(forKey: "cryptoList") {
            if let decodedList = try? JSONDecoder().decode([Crypto].self, from: cryptoList) {
                loadingView.isHidden = false
                defaultImage.isHidden = true
                choiceButton.isHidden = true
                loadingView.startAnimating()
                buttonsHandlerDelegate?.reloadCryptoPressed(cryptoList: decodedList)
            }
        }
    }
    
    @objc func delegateCryptoPressed() {
        buttonsHandlerDelegate?.cryptoChoicePressed()
    }
    
    // Вызывается при установке списка криптовалюты
    func setCrypto(cryptos: [Crypto]?) {
        var cryptoViews: [CryptoView] = []
        if (choice == false) {
            choice = true
            loadingView.stopAnimating()
            choiceButton.isHidden = true
            defaultImage.isHidden = true
            placeholder.addSubview(horizontalStack)
            horizontalStack.edgesToSuperview()
        }
        if var cryptoList = cryptos {
            if (cryptoList.isEmpty) {
                choice = false
                choiceButton.isHidden = false
                defaultImage.isHidden = false
                errorView.isHidden = true
                horizontalStack.isHidden = true
                return
            }
            cryptoList = cryptoList.sorted { $0.id < $1.id }
            errorView.isHidden = true
            horizontalStack.isHidden = false
            horizontalStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
            let leftSpacer: UIView = UIView()
            let rightSpacer: UIView = UIView()
            horizontalStack.addArrangedSubview(leftSpacer)
            horizontalStack.addArrangedSubview(rightSpacer)
            
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
            choiceButton.isHidden = true
            defaultImage.isHidden = true
            horizontalStack.isHidden = true
            errorView.isHidden = false
        }
    }
    
    @objc func reloadCrypto() {
        if let cryptoList = UserDefaults.standard.data(forKey: "cryptoList") {
            if let decodedCryptos = try? JSONDecoder().decode([Crypto].self, from: cryptoList) {
                errorView.isHidden = true
                loadingView.isHidden = false
                loadingView.startAnimating()
                buttonsHandlerDelegate?.reloadCryptoPressed(cryptoList: decodedCryptos)
            }
        }
    }
    
}
