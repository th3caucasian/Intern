//
//  ViewBuilder.swift
//  Intern
//
//  Created by Алан Эркенов on 19.02.2025.
//

import UIKit

class ViewBuilder {
    
    static func createLabel(font: UIFont,text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = font
        label.text = text
        return label
    }
    
    static func createTextLabel(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.text = text
        return label
    }
    
    static func createValueLabel(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = text
        return label
    }
}
