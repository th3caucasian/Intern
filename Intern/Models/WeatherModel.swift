//
//  Weather.swift
//  Intern
//
//  Created by Алан Эркенов on 07.02.2025.
//

struct WeatherModel: Codable {
    let weather: [Weather]
    let main: WeatherMain
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let name: String
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
}

struct Weather: Codable {
    let id: Int
    let description: String
    let icon: String
}

struct WeatherMain: Codable {
    let temp: Double
    let feels_like: Double
    let pressure: Int
    let humidity: Int
}

struct Clouds: Codable {
    let all: Int
}
    
