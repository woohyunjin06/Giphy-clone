//
//  ResponseBody.swift
//  Giphy
//
//  Created by 현진 on 2021/01/10.
//

import Foundation

struct ResponseBody<Data: Decodable>: Decodable {
    let data: Data?
    let meta: Meta
}

struct NoData: Decodable {}

