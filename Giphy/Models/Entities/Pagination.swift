//
//  Pagination.swift
//  Giphy
//
//  Created by 현진 on 2021/01/10.
//

import Foundation

struct Pagination: Decodable {
    let offset: Int
    let totalCount: Int
    let count: Int
    
    enum CodingKeys: String, CodingKey {
        case offset, count
        case totalCount = "total_count"
    }
}
