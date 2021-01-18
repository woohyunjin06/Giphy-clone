//
//  DynamicKey.swift
//  Giphy
//
//  Created by 현진 on 2021/01/18.
//

import Foundation

struct DynamicKey: CodingKey {
    var stringValue: String = ""
    
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    var intValue: Int?
    init?(intValue: Int) {
        self.intValue = intValue
    }
}
