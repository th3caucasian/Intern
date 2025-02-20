//
//  APIHelper.swift
//  Intern
//
//  Created by Алан Эркенов on 19.02.2025.
//

import Moya


enum APIError: Error {
    case parcingFailure
    case networkError
}

class APIHelper {
    
    static let shared = APIHelper()
    
    private init() {}
    
    func getAllCrypto(completition: @escaping (Result<[Crypto],APIError>) -> Void) {
        let moyaProvider = MoyaProvider<CryptoAPI>()
        
        moyaProvider.request(.getAllCrypto) { result in
            switch result {
            case .success(let response):
                do {
                    let decoded = try JSONDecoder().decode([Crypto].self, from: response.data)
                    completition(.success(decoded))
                } catch {
                    completition(.failure(.parcingFailure))
                    print("Ошибка парсинга Crypto (All): \(error)\nresponse: \(response)")
                }
            case .failure(let error):
                print("Ошибка сети \(error.localizedDescription)")
                completition(.failure(.networkError))
            }
        }
    }
    
    
    
    func getSelectedCrypto(selectedCrypto: String?, completition: @escaping (Result<[Crypto], APIError>) -> Void) {
        guard let crypto = selectedCrypto else {
            return
        }
        let moyaProvider = MoyaProvider<CryptoAPI>()
        
        moyaProvider.request(.getSelectedCrypto(crypto)) { result in
            switch result {
            case .success(let response):
                do {
                    let decoded = try JSONDecoder().decode([Crypto].self, from: response.data)
                    completition(.success(decoded))
                } catch {
                    print("Ошибка парсинга Crypto (Selected): \(error)\nresponse: \(response)")
                    completition(.failure(.parcingFailure))
                }
            case .failure(let error):
                print("Ошибка сети \(error.localizedDescription)")
                completition(.failure(.networkError))
            }
        }
        
    }
    
    
    
    func getWeather(latitude: Double, longitude: Double, completition: @escaping (Result<WeatherModel, APIError>) -> Void) {
        let moyaProvider = MoyaProvider<WeatherAPI>()
        
        moyaProvider.request(.getWeather(latitude: latitude, longitude: longitude)) { result in
            switch result {
            case .success(let response):
                do {
                    let decoded = try JSONDecoder().decode(WeatherModel.self, from: response.data)
                    completition(.success(decoded))
                } catch {
                    print("Ошибка парсинга Weather\n\(error)\nresponse: \(response)")
                    completition(.failure(.parcingFailure))
                }
            case .failure(let error):
                print("Ошибка сети \(error.localizedDescription)")
                completition(.failure(.networkError))
            }
        }
    }
}
