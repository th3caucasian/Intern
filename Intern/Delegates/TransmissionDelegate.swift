//
//  TransmissionDelegate.swift
//  Intern
//
//  Created by Алан Эркенов on 06.02.2025.
//


protocol TransmissionDelegate: AnyObject {
    func infoReceived(cardsOrder: [String])
    
    func saveCity(latitude: Double, longitude: Double)
}
