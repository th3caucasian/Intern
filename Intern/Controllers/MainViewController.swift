//
//  ViewController.swift
//  Intern
//
//  Created by Алан Эркенов on 04.02.2025.
//

import UIKit
import TinyConstraints
import Moya

class MainViewController: UIViewController, ButtonsHandlerDelegate, TransmissionDelegate, NetworkDelegate {
    
    private var cardStack: CardStack!
    private var lastDelegateUser: String?
    private var cryptoTimer: Timer?


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        setupNavigationBar()
        
        cardStack = CardStack(frame: UIScreen.main.bounds)
        cardStack.buttonsHandlerDelegate = self
        cardStack.networkDelegate = self
        view.addSubview(cardStack)
        cardStack.edgesToSuperview(insets: TinyEdgeInsets(top: 20, left: 0, bottom: 20, right: 0), usingSafeArea: true)
        cardStack.setupView()
        startTimer()

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
        cryptoList.networkDelegate = self
        self.navigationController?.pushViewController(cryptoList, animated: true)
    }
    
    func reloadCryptoPressed(cryptoList: [Crypto]) {
        fetchCrypto { cryptos in
            let cryptoListIds = Set(cryptoList.map { $0.id.lowercased() })
            let tempList = cryptos?.filter { cryptoListIds.contains($0.id) }
            self.cardStack.saveCryptoList(cryptoList: tempList)
        }
    }
    
    func saveCity(city: City) {
        cardStack.saveCity(city: city, type: lastDelegateUser!)
    }
    
    func saveCryptoList(cryptoList: [Crypto]?) {
        if (cryptoList != nil) && (cryptoList!.isEmpty == false) {
            startTimer()
        } else {
            cryptoTimer?.invalidate()
            cryptoTimer = nil
        }
        cardStack.saveCryptoList(cryptoList: cryptoList)
    }
    
    func fetchCrypto(completition: @escaping ([Crypto]?)->(Void)) {
        let moyaProvider = MoyaProvider<CryptoAPI>()
        
        moyaProvider.request(.getCryptoList) { result in
            switch result {
            case .success(let response):
                do {
                    let decoded = try JSONDecoder().decode([Crypto].self, from: response.data)
                    completition(decoded)
                } catch {
                    print("Ошибка парсинга \(error)")
                }
            case .failure(let error):
                //self.cardStack.saveCryptoList(cryptoList: nil)
                print("Ошибка сети \(error.localizedDescription)")
                completition(nil)
            }
        }
    }
    
    func startTimer() {
        cryptoTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(reloadCryptoByTimer), userInfo: nil, repeats: true)
    }
    
    @objc func reloadCryptoByTimer() {
        if let list = UserDefaults.standard.data(forKey: "cryptoList") {
            if let decodedList = try? JSONDecoder().decode([Crypto].self, from: list) {
//                fetchCrypto { cryptos in
//                    let tempList = cryptos?.filter { decodedList.contains($0) }
//                    self.cardStack.saveCryptoList(cryptoList: tempList)
//                }
            }
        }
    }
}


