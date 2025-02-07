//
//  JSONReader.swift
//  Intern
//
//  Created by Алан Эркенов on 06.02.2025.
//

import Foundation

class JSONReader {
    
    private var cities: [City] = []
    
    func loadCitiesFromFile(fileName: String) -> [City] {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            fatalError("Файл не найден")
        }

        do {
            let data = try Data(contentsOf: url)
            cities = try JSONDecoder().decode([City].self, from: data)
        } catch {
            fatalError("Ошибка чтения json\n\(error.localizedDescription)")
        }
        
        return cities
    }
}
