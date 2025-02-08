//
//  CryptoAPI.swift
//  Intern
//
//  Created by Алан Эркенов on 08.02.2025.
//

import Moya

enum CryptoAPI: TargetType {
    case getCryptoList
    
    var baseURL: URL {
        return URL(string: "https://api.coingecko.com/api/v3")!
    }
    
    var path: String {
        switch self {
        case .getCryptoList:
            return "/coins/markets"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .getCryptoList:
            return .requestParameters(parameters: ["vs_currency": "usd", "order": "market_cap_desc", "per_page": 20, "page": 1, "sparkline": false, "price_change_percentage": "1h"], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["accept": "application/json"]
    }
    
    var sampleData: Data {
        return Data()
    }
}
