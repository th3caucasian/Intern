//
//  CryptoModel.swift
//  Intern
//
//  Created by Алан Эркенов on 08.02.2025.
//


struct Crypto: Codable, Equatable {
    var id: String
    let image: String
    let current_price: Double
    let price_change_percentage_1h_in_currency: Double
}
 
