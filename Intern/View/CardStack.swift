//
//  CardList.swift
//  Intern
//
//  Created by Алан Эркенов on 04.02.2025.
//

import UIKit
import SwiftUICore
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
        cardList[1].cardText.text = "Погода"
        cardList[2].cardText.text = "Курс криптовалют"
        
    }
}
