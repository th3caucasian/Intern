//
//  Card.swift
//  Intern
//
//  Created by Алан Эркенов on 04.02.2025.
//

import UIKit
import TinyConstraints
import MapKit
import Moya

class Card: UIView {
    
    private var choice = false
    private weak var buttonsHandlerDelegate: ButtonsHandlerDelegate?
    private weak var networkDelegate: NetworkDelegate?
    private var cryptoViewUpdater: Timer?
    
    convenience init(buttonsHandlerDelegate: ButtonsHandlerDelegate, networkDelegate: NetworkDelegate) {
        self.init()
        self.buttonsHandlerDelegate = buttonsHandlerDelegate
        self.networkDelegate = networkDelegate
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let settingsButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "settings")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let choiceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Выбрать", for: .normal)
        button.backgroundColor = UIColor(named: "LightBlue")
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 1
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 0.15
        button.layer.masksToBounds = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let placeholder: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let defaultImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "map_bckgrnd")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    

    private let verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fill  
        stack.backgroundColor = .white
        stack.layer.cornerRadius = 20
        stack.layer.shadowColor = UIColor.black.cgColor
        stack.layer.shadowRadius = 5
        stack.layer.shadowOpacity = 0.5
        stack.layer.shadowOffset = CGSize(width: 0, height: 2)
        stack.layer.masksToBounds = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let upperPlaceholder: UIView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let cardText: UILabel = {
        let label = UILabel()
        label.text = "Template"
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sepLine: UIView = {
        let line = UIView()
        line.backgroundColor = .systemGray4
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    private let mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        map.isZoomEnabled = false
        map.isScrollEnabled = false
        map.layer.cornerRadius = 20
        return map
    }()
    
    private let errorView: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue.withAlphaComponent(0.2)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 20
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    private let weatherView = WeatherView()
    
    
    private let horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 8
        return stack
    }()
    
    private let loadingView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Загрузка..."
        label.textAlignment = .center
        return label
    }()

    func setupView() {
        self.addSubview(verticalStack)
        verticalStack.widthToSuperview(multiplier: 0.9)
        verticalStack.centerInSuperview()
        verticalStack.addArrangedSubview(upperPlaceholder)
        verticalStack.addArrangedSubview(sepLine)
        verticalStack.addArrangedSubview(placeholder)
        
        upperPlaceholder.addSubview(cardText)
        upperPlaceholder.addSubview(settingsButton)
        upperPlaceholder.widthToSuperview()
        upperPlaceholder.heightToSuperview(multiplier: 0.15)
        
        placeholder.widthToSuperview()
        placeholder.addSubview(defaultImage)
        placeholder.addSubview(choiceButton)
        placeholder.addSubview(errorView)

        defaultImage.centerInSuperview()
        defaultImage.widthToSuperview(offset: -30)
        
        settingsButton.topToSuperview(offset: 6)
        settingsButton.rightToSuperview(offset: -10)
        
        choiceButton.edgesToSuperview(insets: TinyEdgeInsets(top: 130, left: 100, bottom: 30, right: 100))
        
        cardText.leftToSuperview(offset: 20)
        cardText.topToSuperview(offset: 7)
        
        sepLine.widthToSuperview()
        sepLine.heightToSuperview(multiplier: 0.005)
        
        errorView.edgesToSuperview(insets: TinyEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        errorView.isHidden = true
        
    }
    
    func setupCityCard() {
        choiceButton.addTarget(self, action: #selector(delegateCityChoicePressed), for: .touchUpInside)
        settingsButton.addTarget(self, action: #selector(delegateCityChoicePressed), for: .touchUpInside)
        cardText.text = "Город"
        defaultImage.image = UIImage(named: "map_bckgrnd")
        if let city = UserDefaults.standard.data(forKey: "cityMap") {
            if let decodedCity = try? JSONDecoder().decode(City.self, from: city) {
                setCity(latitude: decodedCity.latitude, longitude: decodedCity.longitude)
            }
        }
    }
    
    
    func setupWeatherCard() {
        choiceButton.addTarget(self, action: #selector(delegateWeatherPressed), for: .touchUpInside)
        settingsButton.addTarget(self, action: #selector(delegateWeatherPressed), for: .touchUpInside)
        cardText.text = "Погода"
        defaultImage.image = UIImage(named: "weather_bckgrnd")
        weatherView.setupView()
        if let city = UserDefaults.standard.data(forKey: "cityWeather") {
            if let decodedCity = try? JSONDecoder().decode(City.self, from: city) {
                setWeather(latitude: decodedCity.latitude, longitude: decodedCity.longitude, name: decodedCity.name)
            }
        }
    }
    
    
    func setupCryptoCard() {
        choiceButton.addTarget(self, action: #selector(delegateCryptoPressed), for: .touchUpInside)
        settingsButton.addTarget(self, action: #selector(delegateCryptoPressed), for: .touchUpInside)
        cardText.text = "Курс криптовалют"
        defaultImage.image = UIImage(named: "crypto_bckgrnd")
        if let cryptoList = UserDefaults.standard.data(forKey: "cryptoList") {
            if let decodedList = try? JSONDecoder().decode([Crypto].self, from: cryptoList) {
                setCrypto(cryptos: decodedList)
            }
        }
    }
    
    
    
    @objc func delegateCityChoicePressed() {
        buttonsHandlerDelegate?.cityChoicePressed(type: "map")
    }
    
    @objc func delegateWeatherPressed() {
        buttonsHandlerDelegate?.cityChoicePressed(type: "weather")
    }
    
    @objc func delegateCryptoPressed() {
        buttonsHandlerDelegate?.cryptoChoicePressed()
    }
    
    
    func setCity(latitude: Double, longitude: Double) {
        if (choice == false) {
            choice = true
            choiceButton.isHidden = true
            defaultImage.isHidden = true
            placeholder.addSubview(mapView)
            mapView.edgesToSuperview(insets: TinyEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude) 
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 20_000, longitudinalMeters: 20_000)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(annotation)
    }
    
    
    
    func setWeather(latitude: Double, longitude: Double, name: String) {
        if (choice == false) {
            choice = true
            choiceButton.isHidden = true
            defaultImage.isHidden = true
            placeholder.addSubview(weatherView)
            placeholder.addSubview(loadingView)
            loadingView.edgesToSuperview()
            weatherView.edgesToSuperview(insets: TinyEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
 
        fetchWeather(latitude: latitude, longitude: longitude) { [weak self] weather in
            if let decodedWeather = weather {
                self?.weatherView.fillData(
                    city: name,
                    image: decodedWeather.weather[0].icon,
                    weather: decodedWeather.weather[0].description,
                    temperature: String(format: "%.1f", decodedWeather.main.temp) + "ºC",
                    feelsLike: String(format: "%.1f", decodedWeather.main.feels_like) + "ºC",
                    wind: String(decodedWeather.wind.speed),
                    windDegree: decodedWeather.wind.deg,
                    pressure: String(decodedWeather.main.pressure),
                    humidity: String(decodedWeather.main.humidity),
                    cloudness: String(decodedWeather.clouds.all),
                    visibility: String(decodedWeather.visibility / 1000))
                
                self?.choiceButton.isHidden = true
                self?.defaultImage.isHidden = true
                self?.errorView.isHidden = true
                self?.weatherView.isHidden = false
                self?.loadingView.isHidden = true
            } else {
                self?.loadingView.isHidden = true
                self?.errorView.isHidden = false
                self?.weatherView.isHidden = true
                self?.errorView.addTarget(self, action: #selector(self?.reloadWeather), for: .touchUpInside)
                self?.errorView.setTitle("При загрузке погоды произошла ошибка", for: .normal)
            }
        }
    }
    
    
    func setCrypto(cryptos: [Crypto]?) {
        var cryptoViews: [CryptoView] = []  // можно оптимизировать за счет этой локальной переменной и проверять на равенство с новым листом
        if (choice == false) {
            choice = true
            choiceButton.isHidden = true
            defaultImage.isHidden = true
            placeholder.addSubview(horizontalStack)
            horizontalStack.edgesToSuperview()
        }
        if let cryptoList = cryptos {
            if (cryptoList.isEmpty) {
                choice = false
                choiceButton.isHidden = false
                defaultImage.isHidden = false
                horizontalStack.removeFromSuperview()
                return
            }
            self.errorView.isHidden = true
            horizontalStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
            let leftSpacer: UIView = UIView()
            let rightSpacer: UIView = UIView()
            horizontalStack.addArrangedSubview(leftSpacer)
            horizontalStack.addArrangedSubview(rightSpacer)
            
            for i in cryptoList.indices {
                cryptoViews.append(CryptoView())
                let crypto = cryptoList[i]
                let dynamic = crypto.current_price / 100 * crypto.price_change_percentage_1h_in_currency
                cryptoViews[i].fillData(cryptoName: crypto.id, cryptoImage: crypto.image, cryptoPrice: String(crypto.current_price) + " $", priceDynamic: String(format: "%.4f", dynamic))
                horizontalStack.insertArrangedSubview(cryptoViews[i], at: horizontalStack.arrangedSubviews.count - 1)
                cryptoViews[i].widthToSuperview(multiplier: 0.3)
                cryptoViews[i].heightToSuperview(multiplier: 0.9)
            }
        } else {
            choiceButton.isHidden = true
            defaultImage.isHidden = true
            self.errorView.isHidden = false
            self.horizontalStack.removeFromSuperview()
            self.errorView.addTarget(self, action: #selector(reloadCrypto), for: .touchUpInside)
            self.errorView.setTitle("При загрузке произошла ошибка", for: .normal)
        }
    }
    
    
    private func fetchWeather(latitude: Double, longitude: Double, completition: @escaping (WeatherModel?)->(Void)) {
        let moyaProvider = MoyaProvider<WeatherAPI>()
        weatherView.isHidden = true
        loadingView.isHidden = false
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
    

    @objc func reloadWeather() {
        if let city = UserDefaults.standard.data(forKey: "cityWeather") {
            if let decodedCity = try? JSONDecoder().decode(City.self, from: city) {
                setWeather(latitude: decodedCity.latitude, longitude: decodedCity.longitude, name: decodedCity.name)
            }
        }
    }
    
    @objc func reloadCrypto() {
        if let cryptoList = UserDefaults.standard.data(forKey: "cryptoList") {
            if let decodedCryptos = try? JSONDecoder().decode([Crypto].self, from: cryptoList) {
                buttonsHandlerDelegate?.reloadCryptoPressed(cryptoList: decodedCryptos)
            }
        }
    }
    
}
