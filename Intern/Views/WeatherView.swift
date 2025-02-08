//
//  WeatherPlaceholder.swift
//  Intern
//
//  Created by Алан Эркенов on 07.02.2025.
//

import UIKit


class WeatherView: UIView {
    
    var weatherText: UILabel?
    var temperatureValue: UILabel?
    var feelsLikeValue: UILabel?
    var windValue: UILabel?
    var pressureValue: UILabel?
    var humidityValue : UILabel?
    var cloudnessValue: UILabel?
    var visibilityValue: UILabel?
    
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
        
    private let weatherImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    

    func setupView() {
        self.backgroundColor = .lightBlue.withAlphaComponent(0.2)
        self.layer.cornerRadius = 20


        let feelsLikeText = createTextLabel(text: "Ощущается как")
        let windText = createTextLabel(text: "Ветер")
        let metersPerSecondText = createTextLabel(text: "м/с")
        let pressureText = createTextLabel(text: "Давление")
        let humidityText = createTextLabel(text: "Влажность")
        let percentageText1 = createTextLabel(text: "%")
        let percentageText2 = createTextLabel(text: "%")
        let cloudnessText = createTextLabel(text: "Облачность")
        let visibilityText = createTextLabel(text: "Видимость")
        let kmText = createTextLabel(text: "км/с")
        let mmRtStText = createTextLabel(text: "м.р.ст")
        
        
        
        weatherText = createTextLabel(text: "пасмурно")
        temperatureValue = createValueLabel(text: "5.1ºC")
        feelsLikeValue = createValueLabel(text: "2.0ºC")
        windValue = createValueLabel(text: "4.02")
        pressureValue = createValueLabel(text: "753.9")
        humidityValue = createValueLabel(text: "70")
        cloudnessValue = createValueLabel(text: "99")
        visibilityValue = createValueLabel(text: "10.0")
        
        self.addSubview(cityLabel)
        self.addSubview(weatherText!)
        self.addSubview(feelsLikeText)
        self.addSubview(feelsLikeValue!)
        self.addSubview(temperatureValue!)
        self.addSubview(windText)
        self.addSubview(windValue!)
        self.addSubview(metersPerSecondText)
        self.addSubview(pressureText)
        self.addSubview(pressureValue!)
        self.addSubview(mmRtStText)
        self.addSubview(humidityText)
        self.addSubview(humidityValue!)
        self.addSubview(percentageText1)
        self.addSubview(cloudnessText)
        self.addSubview(cloudnessValue!)
        self.addSubview(percentageText2)
        self.addSubview(visibilityText)
        self.addSubview(visibilityValue!)
        self.addSubview(kmText)
        
        
        cityLabel.text = "Ростов-на-Дону"
        cityLabel.topToSuperview(offset: 10)
        cityLabel.leftToSuperview(offset: 12)
        
        weatherText?.topToSuperview(offset: 40)
        weatherText?.leftToSuperview(offset: 12)

        feelsLikeText.leftToSuperview(offset: 12)
        feelsLikeText.bottomToSuperview(offset: -10)
        feelsLikeValue?.leftToSuperview(offset: 123)
        feelsLikeValue?.bottomToSuperview(offset: -10)
        
        temperatureValue?.font = UIFont.boldSystemFont(ofSize: 30)
        temperatureValue?.bottomToSuperview(offset: -60)
        temperatureValue?.leftToSuperview(offset: 90)
        
        windText.leftToSuperview(offset: 170)
        windText.bottomToSuperview(offset: -90)
        windValue?.leftToSuperview(offset: 250)
        windValue?.bottomToSuperview(offset: -90)
        metersPerSecondText.rightToSuperview(offset: -30)
        metersPerSecondText.bottomToSuperview(offset: -90)
        
        pressureText.leftToSuperview(offset: 170)
        pressureText.bottomToSuperview(offset: -70)
        pressureValue?.leftToSuperview(offset: 250)
        pressureValue?.bottomToSuperview(offset: -70)
        mmRtStText.leftToSuperview(offset: 295)
        mmRtStText.bottomToSuperview(offset: -70)
        
        humidityText.leftToSuperview(offset: 170)
        humidityText.bottomToSuperview(offset: -50)
        humidityValue?.leftToSuperview(offset: 300)
        humidityValue?.bottomToSuperview(offset: -50)
        percentageText1.leftToSuperview(offset: 325)
        percentageText1.bottomToSuperview(offset: -50)
        
        cloudnessText.leftToSuperview(offset: 170)
        cloudnessText.bottomToSuperview(offset: -30)
        cloudnessValue?.leftToSuperview(offset: 300)
        cloudnessValue?.bottomToSuperview(offset: -30)
        percentageText2.leftToSuperview(offset: 325)
        percentageText2.bottomToSuperview(offset: -30)
        
        visibilityText.leftToSuperview(offset: 170)
        visibilityText.bottomToSuperview(offset: -10)
        visibilityValue?.leftToSuperview(offset: 275)
        visibilityValue?.bottomToSuperview(offset: -10)
        kmText.leftToSuperview(offset: 310)
        kmText.bottomToSuperview(offset: -10)
    }
    
    func createTextLabel(text: String) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        return label
    }
    
    func createValueLabel(text: String) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        return label
    }
}
