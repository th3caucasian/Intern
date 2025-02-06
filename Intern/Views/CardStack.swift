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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initList()
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
            cardList.append(Card())
        }
        cardList[0].cardText.text = "Город"
        cardList[0].defaultImage.image = UIImage(named: "map_bckgrnd")
        cardList[1].cardText.text = "Погода"
        cardList[1].defaultImage.image = UIImage(named: "weather_bckgrnd")
        cardList[2].cardText.text = "Курс криптовалют"
        cardList[2].defaultImage.image = UIImage(named: "crypto_bckgrnd")
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
}
