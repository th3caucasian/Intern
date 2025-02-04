//
//  CardList.swift
//  Intern
//
//  Created by Алан Эркенов on 04.02.2025.
//

import UIKit
import SwiftUICore

class CardList: UIView {
    
    var cardList: [Card] = []
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let cardStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillEqually
        return stack
    }()
    
    func setupView() {
        for card in cardList {
            cardStack.addArrangedSubview(card)
        }
        self.addSubview(cardStack)
        cardStack.width(frame.size.width)
        cardStack.height(frame.size.width)
        cardStack.centerInSuperview()
    }
    
    func initList() {
        for _ in 0...2 {
            cardList.append(Card())
        }
        cardList[0].cardText.text = "Город"
        cardList[1].cardText.text = "Погода"
        cardList[2].cardText.text = "Курс криптовалют"
        
    }
}
