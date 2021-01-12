//
//  Reusable.swift
//  Giphy
//
//  Created by 현진 on 2021/01/11.
//

import UIKit

protocol Reusable {
    static var reuseID: String { get }
}
extension Reusable {
    static var reuseID: String {
        String(describing: self)
    }
}
