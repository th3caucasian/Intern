//
//  buttonsPressDelegate.swift
//  Intern
//
//  Created by Алан Эркенов on 07.02.2025.
//

protocol ButtonsHandlerDelegate: AnyObject {
    // Обработка нажатия выбора города
    func cityChoicePressed(type: DelegateUser)
    
    // Обработка нажатия выбора криптовалюты
    func cryptoChoicePressed()
    
    // Обработка обновления криптовалюты
    func reloadCryptoPressed(cryptoList: [Crypto]?)
    
    // Обработка обновления карты
    func reloadWeatherPressed(weather: WeatherModel)
}
