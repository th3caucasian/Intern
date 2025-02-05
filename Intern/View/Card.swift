    //
    //  Card.swift
    //  Intern
    //
    //  Created by Алан Эркенов on 04.02.2025.
    //

    import UIKit

    class Card: UIView {
        
        var choice = false
        let viewWidth: CGFloat = 370
        let viewHeight: CGFloat = 230
        
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.width(viewWidth)
            self.height(viewHeight)
            setupView()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        

        
        // button
        let choiceButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Выбрать", for: .normal)
            button.backgroundColor = UIColor(red: 0.078, green: 0.600, blue: 0.902, alpha: 1)
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 20
            button.clipsToBounds = true
            return button
        }()
        
        // default background
        let defaultBackground: UIView = {
            let view = UIView()
            view.frame = CGRect(x: 200, y: 0, width: 370, height: 200)
            view.backgroundColor = UIColor(red: 0.178, green: 0.600, blue: 0.902, alpha: 0.2)
            view.layer.cornerRadius = 20
            return view
        }()
        
        // stack
        let verticalStack: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.alignment = .leading
            stack.distribution = .fillProportionally
           
            return stack
        }()
        
        // text
        var cardText: UILabel = {
            let label = UILabel()
            label.text = "Template"
            return label
        }()
        
        
        // map view
        
        // weather view
        
        // cryptocurrency view
        

        func setupView() {
            defaultBackground.width(370)
            defaultBackground.height(200)
            defaultBackground.addSubview(choiceButton)
            choiceButton.centerInSuperview()
            choiceButton.width(100)
            choiceButton.height(40)
            verticalStack.width(viewWidth)
            verticalStack.height(viewHeight)
            verticalStack.addArrangedSubview(cardText)
            verticalStack.addArrangedSubview(defaultBackground)
            self.addSubview(verticalStack)
            verticalStack.centerInSuperview()
        }
    }
