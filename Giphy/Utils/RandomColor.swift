//
//  RandomColor.swift
//  Giphy
//
//  Created by 현진 on 2021/01/19.
//

import UIKit

extension UIColor {
    
    private static let colorSets: [UIColor] = [
        .init(rgb: 0xc5efcb),
        .init(rgb: 0xe2a498),
        .init(rgb: 0xe48488),
        .init(rgb: 0xe66378),
        .init(rgb: 0xcd6d8b),
        .init(rgb: 0x9a80b2),
        .init(rgb: 0x6894d9),
        .init(rgb: 0x7ea2cc),
        .init(rgb: 0x93afbf),
        .init(rgb: 0xf0b67f)
    ]
    
    static func random() -> UIColor {
        colorSets.randomElement()!
    }
    
}
