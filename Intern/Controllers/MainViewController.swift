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
    
    private var lastDelegateUser: DelegateUser?
    private var cryptoTimer: Timer?
    private var apiHelper = APIHelper.shared
    private let cityCard = CityCard()
    private let weatherCard = WeatherCard()
    private let cryptoCard = CryptoCard()
    
    private let cardStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        setupNavigationBar()
        
//        cardStack.buttonsHandlerDelegate = self
//        view.addSubview(cardStack)
//        cardStack.edgesToSuperview(insets: TinyEdgeInsets(top: 20, left: 0, bottom: 20, right: 0), usingSafeArea: true)
//        cardStack.setupView()
        setupStack()

        
        loadSavedInfo()
        startTimer()
    }
    
    private func setupNavigationBar() {
        self.title = "Главный экран"
        if let navigationBar = navigationController?.navigationBar {
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
        settings.cardList = getCardOrder()
        navigationController?.pushViewController(settings, animated: true)
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



extension MainViewController {
    func setupStack() {
        view.addSubview(cardStack)
        cardStack.edgesToSuperview(insets: TinyEdgeInsets(top: 20, left: 0, bottom: 20, right: 0), usingSafeArea: true)
        [cityCard, weatherCard, cryptoCard].forEach{
            cardStack.addArrangedSubview($0)
            $0.setupView(self)
        }
        
        if let savedOrder = UserDefaults.standard.data(forKey: "cardsOrder") {
            if let decodedOrder = try? JSONDecoder().decode([CardType].self, from: savedOrder) {
                reorderCards(newOrder: decodedOrder)
            }
        }
    }
    
    func reorderCards(newOrder: [CardType]) {
        for i in newOrder.indices {
            switch newOrder[i] {
            case .city:
                cityCard.removeFromSuperview()
                cardStack.insertArrangedSubview(cityCard, at: i)
            case .weather:
                weatherCard.removeFromSuperview()
                cardStack.insertArrangedSubview(weatherCard, at: i)
            case .crypto:
                cryptoCard.removeFromSuperview()
                cardStack.insertArrangedSubview(cryptoCard, at: i)
            default:
                fatalError("Неверный элемент в массиве-параметре метода")
            }
        }
    }
    
    func getCardOrder() -> [CardType] {
        var tempList: [CardType] = []
        let cards = cardStack.arrangedSubviews as? [Card]
        cards?.forEach {
            tempList.append($0.cardType) }
        return tempList
    }
    
}


extension MainViewController: TransmissionDelegate {
    
    func infoReceived(cardsOrder: [CardType]) {
        if cardsOrder != getCardOrder() {
            reorderCards(newOrder: cardsOrder)
        }
    }
    
    
    func saveCryptoList(cryptoList: [Crypto]?) {
        if let guardedList = cryptoList {
            if !guardedList.isEmpty {
                startTimer()
            }
        }
        cryptoCard.setCrypto(cryptos: cryptoList)
    }
    

    func saveCity(city: City) {
        switch lastDelegateUser {
        case .map:
            cityCard.setCity(latitude: city.latitude, longitude: city.longitude)
            if let cityEncoded = try? JSONEncoder().encode(city) {
                UserDefaults.standard.set(cityEncoded, forKey: "city")
            }
        case .weather:
            apiHelper.getWeather(latitude: city.latitude, longitude: city.longitude) { [weak self] result in
                switch result {
                case .success(var weather):
                    weather.name = city.name
                    self?.weatherCard.setWeather(weatherModel: weather)
                    if let weatherEncoded = try? JSONEncoder().encode(weather) {
                        UserDefaults.standard.set(weatherEncoded, forKey: "weather")
                    }
                
                case .failure(let apiError):
                    switch apiError {
                    case .parcingFailure:
                        self?.showAlert(title: "Ошибка парсинга погоды", message: "Попробуйте обновить погоду позже")
                    case .networkError:
                        self?.showAlert(title: "Ошибка сети", message: "Не удалось получить данные о погоде. Вероятно у вас не работает интернет.")
                    }
                    self?.weatherCard.setWeather(weatherModel: nil)
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
        self.navigationController?.pushViewController(cryptoList, animated: true)
        cryptoTimer?.invalidate()
        cryptoTimer = nil
    }
    
    func reloadCryptoPressed(cryptoList: [Crypto]?) {
        guard let guardedCrypto = cryptoList else { return }
        if guardedCrypto.isEmpty {
            cryptoCard.setCrypto(cryptos: [])
            return
        }
        var names: String = ""
        cryptoList?.forEach {
            names += "\($0.id.lowercased()),"
        }
        
        apiHelper.getSelectedCrypto(selectedCrypto: names) { [weak self] result in
            switch result {
            case .success(let cryptos):
                let uppercasedCrypto = cryptos.map { crypto in
                    var modifiedCrypto = crypto
                    modifiedCrypto.id = crypto.id.prefix(1).uppercased() + crypto.id.dropFirst()
                    return modifiedCrypto
                }
                self?.cryptoCard.setCrypto(cryptos: uppercasedCrypto)
                if self?.cryptoTimer == nil {
                    self?.startTimer()
                }
                
            case .failure(let apiError):
                switch apiError {
                case .parcingFailure:
                    break
                case .networkError:
                    self?.showAlert(title: "Ошибка сети", message: "Не удалось получить данные о выбранной криптовалюте. Вероятно у вас не работает интернет.")
                    self?.cryptoTimer?.invalidate()
                    self?.cryptoTimer = nil
                    self?.cryptoCard.setCrypto(cryptos: nil)
                }
            }
        }
    }
    
    func reloadWeatherPressed(weather: WeatherModel) {
        let citiesList = JSONReader().loadCitiesFromFile(fileName: "cities")
        let city = citiesList.first { $0.name == weather.name }
        guard let guardedCity = city else {return}
        apiHelper.getWeather(latitude: guardedCity.latitude, longitude: guardedCity.longitude) { [weak self] result in
            switch result {
            
            case .success(var fetchedWeather):
                fetchedWeather.name = guardedCity.name
                self?.weatherCard.setWeather(weatherModel: fetchedWeather)
            
            case .failure(let apiError):
                switch apiError {
                case .parcingFailure:
                    self?.showAlert(title: "Ошибка парсинга погоды", message: "Попробуйте обновить погоду позже")
                case .networkError:
                    self?.showAlert(title: "Ошибка сети", message: "Не удалось получить данные о погоде. Вероятно у вас не работает интернет.")
                }
                self?.weatherCard.setWeather(weatherModel: nil)
            }
        }
    }
    
}


extension MainViewController {
    func loadSavedInfo() {
        if let city = UserDefaults.standard.data(forKey: "city") {
            if let decodedCity = try? JSONDecoder().decode(City.self, from: city) {
                cityCard.setCity(latitude: decodedCity.latitude, longitude: decodedCity.longitude)
            }
        }
        
        
        if let weather = UserDefaults.standard.data(forKey: "weather") {
            if let decodedWeather = try? JSONDecoder().decode(WeatherModel.self, from: weather) {
                reloadWeatherPressed(weather: decodedWeather)
            }
        }
        
        
        if let cryptoList = UserDefaults.standard.data(forKey: "cryptoList") {
            if let decodedList = try? JSONDecoder().decode([Crypto].self, from: cryptoList) {
                reloadCryptoPressed(cryptoList: decodedList)
            }
        }
    }
}

