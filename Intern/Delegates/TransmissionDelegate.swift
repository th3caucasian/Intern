//
//  TransmissionDelegate.swift
//  Intern
//
//  Created by Алан Эркенов on 06.02.2025.
//


protocol TransmissionDelegate: AnyObject {
    
    // Метод сохранения порядка карточек
    func infoReceived(cardsOrder: [CardType])
    
    // Метод сохранения города (и для карты и для погоды)
    func saveCity(city: City)
    
    // Метод сохранения добавленных криптовалют
    func saveCryptoList(cryptoList: [Crypto]?)
}
