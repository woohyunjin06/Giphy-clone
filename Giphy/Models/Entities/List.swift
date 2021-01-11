//
//  List.swift
//  Giphy
//
//  Created by 현진 on 2021/01/11.
//

import Foundation

struct List<Element: Decodable>: Decodable {
    let data: [Element]
    let pagination: Pagination
    let meta: Meta
}
