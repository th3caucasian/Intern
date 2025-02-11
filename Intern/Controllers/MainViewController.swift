//
//  ViewController.swift
//  Intern
//
//  Created by Алан Эркенов on 04.02.2025.
//

import UIKit
import TinyConstraints
import Moya

enum DelegateUser {
    case map, weather
}

enum CryptoQueryType {
    case all, selected
}

// Контроллер главного экрана с карточками
class MainViewController: UIViewController {
    
    private var cardStack: CardStack!
    private var lastDelegateUser: DelegateUser?
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
    
   
    
    func startTimer() {
        cryptoTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(reloadCryptoByTimer), userInfo: nil, repeats: true)
    }
    
    @objc func reloadCryptoByTimer() {
        if let list = UserDefaults.standard.data(forKey: "cryptoList") {
            if let decodedList = try? JSONDecoder().decode([Crypto].self, from: list) {
                reloadCryptoPressed(cryptoList: decodedList)
            }
        }
    }
    
}


extension MainViewController: TransmissionDelegate {
    
    func infoReceived(cardsOrder: [String]) {
        if cardsOrder != cardStack.getCardOrder() {
            cardStack.reorder(newOrder: cardsOrder)
        }
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
    

    func saveCity(city: City) {
        switch lastDelegateUser {
        case .map:
            cardStack.saveCity(city: city)
            if let cityEncoded = try? JSONEncoder().encode(city) {
                UserDefaults.standard.set(cityEncoded, forKey: "city")
            }
        case .weather:
            fetchWeather(latitude: city.latitude, longitude: city.longitude) { fetchedWeather in
                var weather = fetchedWeather
                weather?.name = city.name
                self.cardStack.saveWeather(weather: weather)
                if fetchedWeather != nil {
                    if let weatherEncoded = try? JSONEncoder().encode(weather) {
                        UserDefaults.standard.set(weatherEncoded, forKey: "weather")
                    }
                }
            }
        default:
            fatalError("lastDelegateUser не был инициализировн")
        
        }
    }
    
    
}


extension MainViewController: ButtonsHandlerDelegate {
    
    func cityChoicePressed(type: DelegateUser) {
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
    
    func reloadCryptoPressed(cryptoList: [Crypto]?) {
        if cryptoList == nil || cryptoList!.isEmpty {
            cardStack.saveCryptoList(cryptoList: [])
            return
        }
        
        var names: String? = ""
        cryptoList?.forEach {
            names? += "\($0.id.lowercased()),"
        }
        fetchCrypto(queryType: .selected, selectedCrypto: names) { cryptos in
            let uppercasedCrypto = cryptos?.map { crypto in
                var modifiedCrypto = crypto
                modifiedCrypto.id = crypto.id.prefix(1).uppercased() + crypto.id.dropFirst()
                return modifiedCrypto
            }
            self.cardStack.saveCryptoList(cryptoList: uppercasedCrypto)
        }
    }
    
    func reloadWeatherPressed(weather: WeatherModel) {
        let citiesList = JSONReader().loadCitiesFromFile(fileName: "cities")
        let city = citiesList.first { $0.name == weather.name }!
        fetchWeather(latitude: city.latitude, longitude: city.longitude) { fetchedWeather in
            var weather = fetchedWeather
            weather?.name = city.name
            self.cardStack.saveWeather(weather: weather)
        }
    }
    
}


extension MainViewController: NetworkDelegate {


    func fetchCrypto(queryType: CryptoQueryType, selectedCrypto: String?, completition: @escaping ([Crypto]?)->(Void)) {
        let moyaProvider = MoyaProvider<CryptoAPI>()
        
        switch queryType {
        case .all:
            moyaProvider.request(.getAllCrypto) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoded = try JSONDecoder().decode([Crypto].self, from: response.data)
                        completition(decoded)
                    } catch {
                        print("Ошибка парсинга \(error)")
                    }
                case .failure(let error):
                    print("Ошибка сети \(error.localizedDescription)")
                    completition(nil)
                }
            }
            
        case .selected:
            moyaProvider.request(.getSelectedCrypto(selectedCrypto!)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoded = try JSONDecoder().decode([Crypto].self, from: response.data)
                        completition(decoded)
                    } catch {
                        print("Ошибка парсинга \(error)")
                    }
                case .failure(let error):
                    print("Ошибка сети \(error.localizedDescription)")
                    completition(nil)
                }
            }
            
        }
    }
    
    
    func fetchWeather(latitude: Double, longitude: Double, completition: @escaping (WeatherModel?) -> (Void)) {
        let moyaProvider = MoyaProvider<WeatherAPI>()
        
        moyaProvider.request(.getWeather(latitude: latitude, longitude: longitude)) { result in
            switch result {
            case .success(let response):
                do {
                    let decoded = try JSONDecoder().decode(WeatherModel.self, from: response.data)
                    completition(decoded)
                } catch {
                    print("Ошибка парсинга \(error)")
                }
            case .failure(let error):
                print("Ошибка сети \(error.localizedDescription)")
                completition(nil)
            }
        }
    }
    
    
    
}

