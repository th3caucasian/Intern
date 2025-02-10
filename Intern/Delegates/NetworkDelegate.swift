//
//  NetworkDelegate.swift
//  Intern
//
//  Created by Алан Эркенов on 10.02.2025.
//

protocol NetworkDelegate: AnyObject {
    func fetchCrypto(completition: @escaping ([Crypto]?)->(Void))
}
