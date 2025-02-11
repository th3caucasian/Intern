//
//  WeatherAPI.swift
//  Intern
//
//  Created by Алан Эркенов on 08.02.2025.
//

import Moya

// АПИ для получения данных о погоде
enum WeatherAPI: TargetType {
    case getWeather(latitude: Double, longitude: Double)
    
    var baseURL: URL {
        return URL(string: "https://api.openweathermap.org/data/2.5")!
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
            let apiKey = Bundle.main.object(forInfoDictionaryKey: "WeatherApiKey") as! String
            return .requestParameters(parameters: ["lat": latitude, "lon": longitude, "appid": apiKey, "units": "metric", "lang": "ru"], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var sampleData: Data {
        return Data()
    }
}
