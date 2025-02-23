//
//   SizeMultiplier.swift
//  Intern
//
//  Created by Алан Эркенов on 23.02.2025.
//

import UIKit

class SizeMultiplier {
    static let multiplier = {
        let screenWidth = UIScreen.main.bounds.width
        switch screenWidth {
        case 375:
            print("iPhone 6/7/8/SE (2nd Gen)")
            return 0.96
        case 390:
            print("iPhone 12/13/14")
            return 1
        case 414:
            print("iPhone Plus/Pro Max")
            return 1.06
        default :
            return 1
        }
    }
}
