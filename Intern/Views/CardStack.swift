//
//  CardList.swift
//  Intern
//
//  Created by Алан Эркенов on 04.02.2025.
//

import UIKit
import TinyConstraints

class CardStack: UIView {
    
    private var cardList: [Card] = []
    weak var buttonsHandlerDelegate: ButtonsHandlerDelegate?
    weak var networkDelegate: NetworkDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let cardStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 50
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    func setupView() {
        initList()
        self.addSubview(cardStack)
        cardStack.edgesToSuperview()
        cardStack.centerInSuperview()
        cardList.forEach {
            cardStack.addArrangedSubview($0)
            $0.setupView()
        }
    }
    
    private func initList() {
        for _ in 0...2 {
            cardList.append(Card(buttonsHandlerDelegate: buttonsHandlerDelegate!, networkDelegate: networkDelegate!))
        }
        cardList[0].setupCityCard()
        cardList[1].setupWeatherCard()
        cardList[2].setupCryptoCard()
        if let savedOrder = UserDefaults.standard.array(forKey: "cardsOrder") as? [String] {
            reorder(newOrder: savedOrder)
        }
    }
    
    func reorder(newOrder: [String]) {
        var tempList: [Card] = []
        newOrder.forEach {
            switch $0 {
            case "Город":
                tempList.append(cardList.first {$0.cardText.text! == "Город"}!)
            case "Погода":
                tempList.append(cardList.first {$0.cardText.text! == "Погода"}!)
            case "Курс криптовалют":
                tempList.append(cardList.first {$0.cardText.text! == "Курс криптовалют"}!)
            default:
                fatalError("Несоответствие списков")
            }
        }
        cardList = tempList
        cardStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        cardList.forEach { cardStack.addArrangedSubview($0) }
    }
    
    func getCardOrder() -> [String] {
        var tempList: [String] = []
        cardList.forEach { tempList.append($0.cardText.text!) }
        return tempList
    }
    
    func saveCity(city: City, type: String) {
        switch type {
        case "map":
            let cityCard = cardList.first {$0.cardText.text! == "Город"}!
            cityCard.setCity(latitude: city.latitude, longitude: city.longitude)
            if let cityEncoded = try? JSONEncoder().encode(city) {
                UserDefaults.standard.set(cityEncoded, forKey: "cityMap")
            }
        case "weather":
            let weatherCard = cardList.first {$0.cardText.text! == "Погода"}!
            weatherCard.setWeather(latitude: city.latitude, longitude: city.longitude, name: city.name)
            if let cityEncoded = try? JSONEncoder().encode(city) {
                UserDefaults.standard.set(cityEncoded, forKey: "cityWeather")
            }
        default:
            fatalError("Неверный параметр был передан в функцию")
        }
    }
    
    func saveCryptoList(cryptoList: [Crypto]?) {
        let cryptoView = cardList.first {$0.cardText.text! == "Курс криптовалют"}!
        cryptoView.setCrypto(cryptos: cryptoList)
    }
}
