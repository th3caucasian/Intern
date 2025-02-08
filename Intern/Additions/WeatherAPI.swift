//
//  WeatherAPI.swift
//  Intern
//
//  Created by Алан Эркенов on 08.02.2025.
//

import Moya

enum WeatherAPI: TargetType {
    case getWeather(latitude: Double, longitude: Double)
    
    var baseURL: URL {
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}")!
    }
    
    var path: String {
        switch self {
        case .getWeather:
            return "/weather"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .getWeather(let latitude, let longitude):
            let apiKey = Bundle.main.infoDictionary?["API key"] as! String
            return .requestParameters(parameters: ["lat": latitude, "lon": longitude, "appid": apiKey], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var sampleData: Data {
        return Data()
    }
}
