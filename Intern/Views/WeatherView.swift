//
//  WeatherPlaceholder.swift
//  Intern
//
//  Created by Алан Эркенов on 07.02.2025.
//

import UIKit


class WeatherView: UIView {
    
    var cityText: UILabel?
    var weatherText: UILabel?
    var temperatureValue: UILabel?
    var feelsLikeValue: UILabel?
    var windValue: UILabel?
    var pressureValue: UILabel?
    var humidityValue : UILabel?
    var cloudnessValue: UILabel?
    var visibilityValue: UILabel?
    
    
    private let weatherImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let windArrow: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "location.north.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func fillData(city: String, weather: String, temperature: String, feelsLike: String, wind: String, windDegree: Int, pressure: String, humidity: String, cloudness: String, visibility: String) {
        cityText!.text = city
        weatherText!.text = weather
        temperatureValue!.text = temperature
        feelsLikeValue!.text = feelsLike
        windValue!.text = wind
        windArrow.transform = CGAffineTransform(rotationAngle: CGFloat(windDegree) * CGFloat.pi / 180)
        pressureValue!.text = pressure
        humidityValue!.text = humidity
        cloudnessValue!.text = cloudness
        visibilityValue!.text = visibility

    }

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
        let kmText = createTextLabel(text: "км")
        let mmRtStText = createTextLabel(text: "м.р.ст")
        
        
        cityText = createValueLabel(text: "")
        weatherText = createTextLabel(text: "")
        temperatureValue = createValueLabel(text: "")
        feelsLikeValue = createValueLabel(text: "")
        windValue = createValueLabel(text: "")
        pressureValue = createValueLabel(text: "")
        humidityValue = createValueLabel(text: "")
        cloudnessValue = createValueLabel(text: "")
        visibilityValue = createValueLabel(text: "")
        
        
        self.addSubview(cityText!)
        self.addSubview(weatherText!)
        self.addSubview(feelsLikeText)
        self.addSubview(feelsLikeValue!)
        self.addSubview(temperatureValue!)
        self.addSubview(windText)
        self.addSubview(windValue!)
        self.addSubview(windArrow)
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
        
        cityText?.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        cityText?.topToSuperview(offset: 10)
        cityText?.leftToSuperview(offset: 12)
        
        weatherText?.topToSuperview(offset: 40)
        weatherText?.leftToSuperview(offset: 12)

        temperatureValue?.font = UIFont.boldSystemFont(ofSize: 30)
        temperatureValue?.bottomToSuperview(offset: -60)
        temperatureValue?.rightToLeft(of: pressureText, offset: -5)
        
        feelsLikeText.leftToSuperview(offset: 12)
        feelsLikeText.bottomToSuperview(offset: -10)
        feelsLikeValue?.rightToLeft(of: visibilityText, offset: -5)
        feelsLikeValue?.bottomToSuperview(offset: -10)
        
        
        windText.leftToSuperview(offset: 170)
        windText.bottomToSuperview(offset: -90)
        windValue?.leftToSuperview(offset: 250)
        windValue?.bottomToSuperview(offset: -90)
        metersPerSecondText.leftToRight(of: windValue!, offset: 5)
        metersPerSecondText.bottomToSuperview(offset: -90)
        windArrow.bottomToSuperview(offset: -90)
        windArrow.rightToSuperview(offset: -10)
        
        pressureText.leftToSuperview(offset: 170)
        pressureText.bottomToSuperview(offset: -70)
        pressureValue?.rightToLeft(of: mmRtStText, offset: -5)
        pressureValue?.bottomToSuperview(offset: -70)
        mmRtStText.rightToSuperview(offset: -5)
        mmRtStText.bottomToSuperview(offset: -70)
        
        humidityText.leftToSuperview(offset: 170)
        humidityText.bottomToSuperview(offset: -50)
        humidityValue?.rightToLeft(of: percentageText1, offset: -5)
        humidityValue?.bottomToSuperview(offset: -50)
        percentageText1.rightToSuperview(offset: -5)
        percentageText1.bottomToSuperview(offset: -50)
        
        cloudnessText.leftToSuperview(offset: 170)
        cloudnessText.bottomToSuperview(offset: -30)
        cloudnessValue?.rightToLeft(of: percentageText2, offset: -5)
        cloudnessValue?.bottomToSuperview(offset: -30)
        percentageText2.rightToSuperview(offset: -5)
        percentageText2.bottomToSuperview(offset: -30)
        
        visibilityText.leftToSuperview(offset: 170)
        visibilityText.bottomToSuperview(offset: -10)
        visibilityValue?.rightToLeft(of: kmText, offset: -5)
        visibilityValue?.bottomToSuperview(offset: -10)
        kmText.rightToSuperview(offset: -5)
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
