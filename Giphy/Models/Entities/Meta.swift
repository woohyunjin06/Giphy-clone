//
//  Meta.swift
//  Giphy
//
//  Created by 현진 on 2021/01/10.
//

import Foundation

struct Meta: Decodable {
    let msg: String
    let status: Int
    let responseId: String
    
    enum CodingKeys: String, CodingKey {
        case msg, status
        case responseId = "response_id"
    }
}
