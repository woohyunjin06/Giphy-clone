//
//  Server.swift
//  Giphy
//
//  Created by 현진 on 2021/01/10.
//

import Foundation

class Server {
    
    fileprivate static let ServerURL = "https://api.giphy.com/v1"
    
    static func baseURL(endpoint: String) -> URL {
        guard let baseURL = URL(string: "\(ServerURL)\(endpoint)") else { fatalError("Incorrect endpoint") }
        return baseURL
    }
}
