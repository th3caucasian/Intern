//
//  buttonsPressDelegate.swift
//  Intern
//
//  Created by Алан Эркенов on 07.02.2025.
//

protocol ButtonsHandlerDelegate: AnyObject {
    func cityChoicePressed(type: DelegateUser)
    
    func cryptoChoicePressed()
    
    func reloadCryptoPressed(cryptoList: [Crypto]?)
    
    func reloadWeatherPressed(weather: WeatherModel)
}
