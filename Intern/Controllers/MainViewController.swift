//
//  ViewController.swift
//  Intern
//
//  Created by Алан Эркенов on 04.02.2025.
//

import UIKit
import TinyConstraints
import Moya

enum CitiesListUser {
    case map, weather
}


// Контроллер главного экрана с карточками
class MainViewController: UIViewController {
    
    private var lastCitiesListUser: CitiesListUser?
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: ^"edit_order_button", style: .plain, target: self, action: #selector(buttonEditPressed))
        title = ^"main_screen_title"
        setupStack()
        loadSavedInfo()
        activateButtonsHandler()
        startTimer()
    }

    
    @objc func buttonEditPressed() {
        let settings = SettingsController()
        settings.transmissionDelegate = self
        settings.cardList = getCardOrder()
        navigationController?.pushViewController(settings, animated: true)
    }
    
   
    func startTimer() {
        cryptoTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(reloadCryptoPressed), userInfo: nil, repeats: true)
    }
}


// Методы для настройки и работы с CardStack
extension MainViewController {
    private func setupStack() {
        view.addSubview(cardStack)
        cardStack.edgesToSuperview(insets: TinyEdgeInsets(top: 20, left: 0, bottom: 20, right: 0), usingSafeArea: true)
        [cityCard, weatherCard, cryptoCard].forEach {
            cardStack.addArrangedSubview($0)
            $0.setupView()
        }
        
        if let savedOrder = UserDefaults.standard.data(forKey: "cardsOrder") {
            if let decodedOrder = try? JSONDecoder().decode([CardType].self, from: savedOrder) {
                reorderCards(newOrder: decodedOrder)
            }
        }
    }
    
    private func reorderCards(newOrder: [CardType]) {
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
                print("Неверный элемент в массиве-параметре метода")
            }
        }
    }
    
    private func getCardOrder() -> [CardType] {
        var tempList: [CardType] = []
        let cards = cardStack.arrangedSubviews as? [Card]
        cards?.forEach {
            tempList.append($0.cardType) }
        return tempList
    }
    
}



// Расширение добавляет метод подгрузки сохраненной инфы
extension MainViewController {
    private func loadSavedInfo() {
        if let city = UserDefaults.standard.data(forKey: "city") {
            if let decodedCity = try? JSONDecoder().decode(City.self, from: city) {
                cityCard.setCity(latitude: decodedCity.latitude, longitude: decodedCity.longitude)
            }
        }
        reloadWeatherPressed()
        reloadCryptoPressed()
    }
}


// Добавление соответствия протоколу
extension MainViewController: InfoReceiverDelegate {
    func cardOrderChanged(cardsOrder: [CardType]) {
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
        switch lastCitiesListUser {
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
                        self?.showAlert(title: ^"parcing_error_weather", message: ^"error_parcing_weather_message")
                    case .networkError:
                        self?.showAlert(title: ^"network_error", message: ^"network_error_weather_message")
                    }
                    self?.weatherCard.setWeather(weatherModel: nil)
                }
            }
        default:
            print("lastDelegateUser не был инициализировн")
        }
    }
}


// Добавление метода настройки обработчиков нажатия кнопок в Card
extension MainViewController {
    private func activateButtonsHandler() {
        cityCard.handleAction = { [weak self] action in
            switch action {
            case .selectPressed:
                self?.selectCityPressed()
            default:
                break
            }
        }
        
        weatherCard.handleAction = { [weak self] action in
            switch action {
            case .selectPressed:
                self?.selectWeatherPressed()
            case .reloadPressed:
                self?.reloadWeatherPressed()
            }
        }
        
        cryptoCard.handleAction = { [weak self] action in
            switch action {
            case .selectPressed:
                self?.selectCryptoPressed()
            case .reloadPressed:
                self?.reloadCryptoPressed()
            }
        }
    }
    
    
    private func selectCityPressed() {
        let citiesList = CitiesListController()
        citiesList.transmissionDelegate = self
        lastCitiesListUser = .map
        self.navigationController?.pushViewController(citiesList, animated: true)
    }
    
    private func selectWeatherPressed() {
        let citiesList = CitiesListController()
        citiesList.transmissionDelegate = self
        lastCitiesListUser = .weather
        self.navigationController?.pushViewController(citiesList, animated: true)
    }
    
    private func reloadWeatherPressed() {
        guard let encodedWeather = UserDefaults.standard.data(forKey: "weather") else {
            print("Значение weather не было найдено в UserDefaults")
            weatherCard.stopLoading()
            return
        }
        guard let weather = try? JSONDecoder().decode(WeatherModel.self, from: encodedWeather) else {
            print("Не удалось декодировать информацию в WeatherModel")
            return
        }
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
                    self?.showAlert(title: ^"error_parcing_weather", message: ^"error_parcing_weather_message")
                case .networkError:
                    self?.showAlert(title: ^"network_error", message: ^"network_error_weather_message")
                }
                self?.weatherCard.setWeather(weatherModel: nil)
            }
        }
    }
    
    private func selectCryptoPressed() {
        let cryptoList = CryptoListController()
        cryptoList.transmissionDelegate = self
        navigationController?.pushViewController(cryptoList, animated: true)
        cryptoTimer?.invalidate()
        cryptoTimer = nil
    }
    
    @objc private func reloadCryptoPressed() {
        guard let encodedCrypto = UserDefaults.standard.data(forKey: "cryptoList") else {
            print("Значение cryptoList не было найдено в UserDefaults")
            cryptoCard.stopLoading()
            cryptoTimer?.invalidate()
            cryptoTimer = nil
            return
        }
        guard let cryptoList = try? JSONDecoder().decode([Crypto].self, from: encodedCrypto) else {
            print("Не удалось декодироваться информацию в Crypto")
            return
        }
        if cryptoList.isEmpty {
            cryptoCard.setCrypto(cryptos: [])
            return
        }
        var names: String = ""
        cryptoList.forEach {
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
                    self?.showAlert(title: ^"network_error", message: ^"network_error_weather_message")
                    self?.cryptoTimer?.invalidate()
                    self?.cryptoTimer = nil
                    self?.cryptoCard.setCrypto(cryptos: nil)
                }
            }
        }
    }
}


