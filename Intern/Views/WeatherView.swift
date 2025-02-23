//
//  WeatherPlaceholder.swift
//  Intern
//
//  Created by Алан Эркенов on 07.02.2025.
//

import UIKit
import Kingfisher
import TinyConstraints

class WeatherView: UIView {
    
    private var cityText = ViewBuilder.createLabel(font: .systemFont(ofSize: 25, weight: .bold), text: "")
    private var weatherText = ViewBuilder.createTextLabel(text: "")
    private var temperatureValue = ViewBuilder.createLabel(font: .systemFont(ofSize: 22, weight: .bold), text: "")
    private var feelsLikeValue = ViewBuilder.createLabel(font: .systemFont(ofSize: 13, weight: .bold), text: "")
    private var windValue = ViewBuilder.createValueLabel(text: "")
    private var pressureValue = ViewBuilder.createValueLabel(text: "")
    private var humidityValue = ViewBuilder.createValueLabel(text: "")
    private var cloudnessValue = ViewBuilder.createValueLabel(text: "")
    private var visibilityValue = ViewBuilder.createValueLabel(text: "")
    
    
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
        imageView.tintColor = .black
        return imageView
    }()
    

    func fillData(city: String, image: String, weather: String, temperature: String, feelsLike: String, wind: String, windDegree: Int, pressure: String, humidity: String, cloudness: String, visibility: String) {
        cityText.text = city
        weatherText.text = weather
        weatherImage.kf.setImage(with: URL(string: "https://openweathermap.org/img/wn/\(image)@2x.png"))
        temperatureValue.text = temperature
        feelsLikeValue.text = feelsLike
        windValue.text = wind
        windArrow.transform = CGAffineTransform(rotationAngle: CGFloat(windDegree) * CGFloat.pi / 180)
        pressureValue.text = pressure
        humidityValue.text = humidity
        cloudnessValue.text = cloudness
        visibilityValue.text = visibility

    }

    func setupView() {
        backgroundColor = .lightBlue.withAlphaComponent(0.2)
        layer.cornerRadius = 20

        let feelsLikeText = ViewBuilder.createTextLabel(text: "Ощущается как")
        let windText = ViewBuilder.createTextLabel(text: "Ветер")
        let metersPerSecondText = ViewBuilder.createTextLabel(text: "м/с")
        let pressureText = ViewBuilder.createTextLabel(text: "Давление")
        let humidityText = ViewBuilder.createTextLabel(text: "Влажность")
        let percentageText1 = ViewBuilder.createTextLabel(text: "%")
        let percentageText2 = ViewBuilder.createTextLabel(text: "%")
        let cloudnessText = ViewBuilder.createTextLabel(text: "Облачность")
        let visibilityText = ViewBuilder.createTextLabel(text: "Видимость")
        let kmText = ViewBuilder.createTextLabel(text: "км")
        let mmRtStText = ViewBuilder.createTextLabel(text: "м.р.ст")

                
        [cityText, weatherText, weatherImage, feelsLikeText, feelsLikeValue, temperatureValue, windText, windValue, windArrow, metersPerSecondText, pressureText, pressureValue, mmRtStText, humidityText, humidityValue, percentageText1, cloudnessText, cloudnessValue, percentageText2, visibilityText, visibilityValue, kmText].forEach(addSubview(_:))
        
        cityText.edgesToSuperview(excluding: [.right, .bottom], insets: TinyEdgeInsets(top: 10, left: 12, bottom: 0, right: 0))

        weatherText.edgesToSuperview(excluding: [.bottom, .right], insets: TinyEdgeInsets(top: 40, left: 12, bottom: 0, right: 0))
        
        weatherImage.topToSuperview(offset: 50)
        weatherImage.rightToLeft(of: temperatureValue, offset: 5)
        
        temperatureValue.bottomToSuperview(offset: -60)
        temperatureValue.rightToLeft(of: pressureText, offset: -5)
        
        feelsLikeText.edgesToSuperview(excluding: [.top, .right], insets: TinyEdgeInsets(top: 0, left: 12, bottom: 10, right: 0))
        feelsLikeValue.rightToLeft(of: visibilityText, offset: -5)
        feelsLikeValue.bottomToSuperview(offset: -10)
        
        windText.edgesToSuperview(excluding: [.top, .right], insets: TinyEdgeInsets(top: 0, left: 170, bottom: 90, right: 0))
        windValue.rightToLeft(of: metersPerSecondText, offset: -5)
        windValue.bottomToSuperview(offset: -90)
        metersPerSecondText.rightToLeft(of: windArrow, offset: -7)
        metersPerSecondText.bottomToSuperview(offset: -90)
        windArrow.edgesToSuperview(excluding: [.top, .left], insets: TinyEdgeInsets(top: 0, left: 0, bottom: 90, right: 10))

        pressureText.edgesToSuperview(excluding: [.top, .right], insets: TinyEdgeInsets(top: 0, left: 170, bottom: 70, right: 0))
        pressureValue.rightToLeft(of: mmRtStText, offset: -5)
        pressureValue.bottomToSuperview(offset: -70)
        mmRtStText.edgesToSuperview(excluding: [.top, .left], insets: TinyEdgeInsets(top: 0, left: 0, bottom: 70, right: 5))

        humidityText.edgesToSuperview(excluding: [.top, .right], insets: TinyEdgeInsets(top: 0, left: 170, bottom: 50, right: 0))
        humidityValue.rightToLeft(of: percentageText1, offset: -5)
        humidityValue.bottomToSuperview(offset: -50)
        percentageText1.edgesToSuperview(excluding: [.top, .left], insets: TinyEdgeInsets(top: 0, left: 0, bottom: 50, right: 5))
        
        cloudnessText.edgesToSuperview(excluding: [.top, .right], insets: TinyEdgeInsets(top: 0, left: 170, bottom: 30, right: 0))
        cloudnessValue.rightToLeft(of: percentageText2, offset: -5)
        cloudnessValue.bottomToSuperview(offset: -30)
        percentageText2.edgesToSuperview(excluding: [.top, .left], insets: TinyEdgeInsets(top: 0, left: 0, bottom: 30, right: 5))
        
        visibilityText.edgesToSuperview(excluding: [.top, .right], insets: TinyEdgeInsets(top: 0, left: 170, bottom: 10, right: 0))
        visibilityValue.rightToLeft(of: kmText, offset: -5)
        visibilityValue.bottomToSuperview(offset: -10)
        kmText.edgesToSuperview(excluding: [.top, .left], insets: TinyEdgeInsets(top: 0, left: 0, bottom: 10, right: 5))
    }
    
}
