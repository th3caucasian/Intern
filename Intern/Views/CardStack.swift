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
    
    private let cardStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    func setupView() {
        [CityCard(), WeatherCard(), CryptoCard()].forEach{cardList.append($0)}
        
        addSubview(cardStack)
        cardStack.edgesToSuperview()
        cardList.forEach {
            cardStack.addArrangedSubview($0)
            $0.setupView(buttonsHandlerDelegate, networkDelegate)
        }
        
        if let savedOrder = UserDefaults.standard.data(forKey: "cardsOrder") {
            if let decodedOrder = try? JSONDecoder().decode([CardType].self, from: savedOrder) {
                reorder(newOrder: decodedOrder)
            }
        }
    }
    
    func reorder(newOrder: [CardType]) {
        var tempList: [Card] = []
        newOrder.forEach {
            switch $0 {
            case .city:
                tempList.append(cardList.first {$0.cardType == .city} ?? CityCard())
            case .weather:
                tempList.append(cardList.first {$0.cardType == .weather} ?? WeatherCard())
            case .crypto:
                tempList.append(cardList.first {$0.cardType == .crypto} ?? CryptoCard())
            default:
                fatalError("Несоответствие списков")
            }
        }
        cardList = tempList
        cardStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        cardList.forEach { cardStack.addArrangedSubview($0) }
    }
    
    func getCardOrder() -> [CardType] {
        var tempList: [CardType] = []
        cardList.forEach { tempList.append($0.cardType) }
        return tempList
    }

    
    func saveCity(city: City) {
        let cityCard = cardList.first {$0.cardText.text! == "Город"} as? CityCard
        cityCard?.setCity(latitude: city.latitude, longitude: city.longitude)
    }
    
    func saveWeather(weather: WeatherModel?) {
        let weatherCard = cardList.first {$0.cardText.text! == "Погода"} as? WeatherCard
        weatherCard?.setWeather(weatherModel: weather)
    }
    
    func saveCryptoList(cryptoList: [Crypto]?) {
        let cryptoView = cardList.first {$0.cardText.text! == "Курс криптовалют"} as? CryptoCard
        cryptoView?.setCrypto(cryptos: cryptoList)
    }
    
}
