//
//  TransmissionDelegate.swift
//  Intern
//
//  Created by Алан Эркенов on 06.02.2025.
//


protocol InfoReceiverDelegate: AnyObject {
    
    // Метод сохранения порядка карточек
    func cardOrderChanged(cardsOrder: [CardType])
    
    // Метод сохранения города (и для карты и для погоды)
    func saveCity(city: City)
    
    // Метод сохранения добавленных криптовалют
    func saveCryptoList(cryptoList: [Crypto]?)
}
