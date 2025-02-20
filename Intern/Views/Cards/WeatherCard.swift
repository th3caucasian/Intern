//
//  WeatherCard.swift
//  Intern
//
//  Created by Алан Эркенов on 17.02.2025.
//

import MapKit
import TinyConstraints

class WeatherCard: Card {
    
    private let weatherView = WeatherView()
    
    
    override func setupView(_ buttonsHandlerDelegate: ButtonsHandlerDelegate?) {
        super.setupView(buttonsHandlerDelegate)
        
        [choiceButton, settingsButton].forEach {
            $0.addTarget(self, action: #selector(delegateWeatherPressed), for: .touchUpInside)
        }
        cardText.text = "Погода"
        defaultImage.image = UIImage(named: "weather_bckgrnd")
        weatherView.setupView()
        errorView.addTarget(self, action: #selector(reloadWeather), for: .touchUpInside)
        errorView.setTitle("При загрузке погоды произошла ошибка", for: .normal)
        cardType = .weather
        startLoading()
    }
    
    
    @objc func delegateWeatherPressed() {
        buttonsHandlerDelegate?.cityChoicePressed(type: DelegateUser.weather)
    }
    
    // Вызывается при установке города для погоды
    func setWeather(weatherModel: WeatherModel?) {
        if (choice == false) {
            choice = true
            [choiceButton, defaultImage].forEach {$0.isHidden = true}
            [weatherView, loadingView].forEach {placeholder.addSubview($0)}
            loadingView.centerInSuperview()
            weatherView.edgesToSuperview(insets: TinyEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
        if let weather = weatherModel {
            weatherView.fillData(
                city: weather.name,
                image: weather.weather[0].icon,
                weather: weather.weather[0].description,
                temperature: String(format: "%.1f", weather.main.temp) + "ºC",
                feelsLike: String(format: "%.1f", weather.main.feels_like) + "ºC",
                wind: String(weather.wind.speed),
                windDegree: weather.wind.deg,
                pressure: String(weather.main.pressure),
                humidity: String(weather.main.humidity),
                cloudness: String(weather.clouds.all),
                visibility: String(weather.visibility / 1000)
            )
            loadingView.stopAnimating()
            [choiceButton, defaultImage, errorView].forEach {$0.isHidden = true}
            weatherView.isHidden = false
        } else {
            loadingView.stopAnimating()
            errorView.isHidden = false
            weatherView.isHidden = true
        }
    }
    
    
    @objc func reloadWeather() {
        if let weather = UserDefaults.standard.data(forKey: "weather") {
            if let decodedWeather = try? JSONDecoder().decode(WeatherModel.self, from: weather) {
                errorView.isHidden = true
                loadingView.isHidden = false
                loadingView.startAnimating()
                buttonsHandlerDelegate?.reloadWeatherPressed(weather: decodedWeather)
            }
        }
    }
    
}
