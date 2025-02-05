//
//  CardList.swift
//  Intern
//
//  Created by Алан Эркенов on 04.02.2025.
//

import UIKit
import SwiftUICore

class CardStack: UIView {
    
    private var cardList: [Card] = []
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        initList()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let cardStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillEqually
        return stack
    }()
    
    private func setupView() {
        cardList.forEach(cardStack.addArrangedSubview)
        self.addSubview(cardStack)
        cardStack.width(self.frame.width)
        cardStack.height(self.frame.height - 150)
        cardStack.centerInSuperview()
    }
    
    private func initList() {
        for _ in 0...2 {
            cardList.append(Card())
        }
        cardList[0].cardText.text = "Город"
        cardList[1].cardText.text = "Погода"
        cardList[2].cardText.text = "Курс криптовалют"
        
    }
}
