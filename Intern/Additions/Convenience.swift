//
//  UIViewController+Convenience.swift
//  Intern
//
//  Created by Алан Эркенов on 21.02.2025.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

extension Int {
    func scaleValue() -> CGFloat {
        let baseScale: CGFloat = 402 * 874
        let area = UIScreen.main.bounds.width * UIScreen.main.bounds.height
        let scale = area / baseScale
        let scaledValue = CGFloat(self) * scale
        return scaledValue
    }
}

prefix operator ^
prefix func ^ (string: String) -> String {
    return NSLocalizedString(string, comment: "")
}

