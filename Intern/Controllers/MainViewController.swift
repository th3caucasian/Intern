//
//  ViewController.swift
//  Intern
//
//  Created by Алан Эркенов on 04.02.2025.
//

import UIKit
import TinyConstraints
import Moya

class MainViewController: UIViewController, ButtonsHandlerDelegate, TransmissionDelegate {
    
    private var cardStack: CardStack!
    private var lastDelegateUser: String?


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        setupNavigationBar()
        
        cardStack = CardStack(frame: UIScreen.main.bounds)
        cardStack.buttonsHandlerDelegate = self
        view.addSubview(cardStack)
        cardStack.edgesToSuperview(insets: TinyEdgeInsets(top: 30, left: 0, bottom: 30, right: 0), usingSafeArea: true)
        cardStack.setupView()
        

    }
    
    private func setupNavigationBar() {
        self.title = "Главный экран"
        if let navigationBar = self.navigationController?.navigationBar {
            if #available(iOS 13.0, *) {
                let appearance = UINavigationBarAppearance()
                appearance.configureWithOpaqueBackground()
                appearance.backgroundColor = .lightBlue
                appearance.titleTextAttributes = [
                    .font: UIFont.systemFont(ofSize: 22, weight: .semibold),
                    .foregroundColor: UIColor.white
                ]
                navigationBar.scrollEdgeAppearance = appearance
                navigationBar.standardAppearance = appearance
                navigationBar.compactAppearance = appearance
                navigationBar.tintColor = .white
            }
            else {
                navigationBar.tintColor = .white
                navigationBar.backgroundColor = .lightBlue
                navigationBar.titleTextAttributes = [
                    .font: UIFont.systemFont(ofSize: 22, weight: .semibold),
                    .foregroundColor: UIColor.white
                ]
            }
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(buttonEditPressed))
    }
    
    
    @objc func buttonEditPressed() {
        let settings = SettingsController()
        settings.transmissionDelegate = self
        settings.cardList = cardStack.getCardOrder()
        self.navigationController?.pushViewController(settings, animated: true)
    }
    
    func infoReceived(cardsOrder: [String]) {
        if cardsOrder != cardStack.getCardOrder() {
            cardStack.reorder(newOrder: cardsOrder)
        }
    }
    
    func cityChoicePressed(type: String) {
        lastDelegateUser = type
        let citiesList = CitiesListController()
        citiesList.transmissionDelegate = self
        self.navigationController?.pushViewController(citiesList, animated: true)
    }
    
    func cryptoChoicePressed() {
        let cryptoList = CryptoListController()
        cryptoList.transmissionDelegate = self
        self.navigationController?.pushViewController(cryptoList, animated: true)
    }
    
    func saveCity(city: City) {
        cardStack.saveCity(city: city, type: lastDelegateUser!)
    }
    
    func saveCryptoList(cryptoList: [Crypto]) {
        cardStack.saveCryptoList(cryptoList: cryptoList)
    }
}


