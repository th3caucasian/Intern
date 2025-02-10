//
//  buttonsPressDelegate.swift
//  Intern
//
//  Created by Алан Эркенов on 07.02.2025.
//

protocol ButtonsHandlerDelegate: AnyObject {
    func cityChoicePressed(type: String)
    
    func cryptoChoicePressed()
    
    func reloadCryptoPressed(cryptoList: [Crypto])
}
