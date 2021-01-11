//
//  GIFs.swift
//  Giphy
//
//  Created by 현진 on 2021/01/10.
//

import Moya

enum GIFs {
    case trending([String : Any])
}

extension GIFs: TargetType {
    var baseURL: URL {
        Server.baseURL(endpoint: "/gifs")
    }
    
    var path: String {
        switch self {
        case .trending:
            return "/trending"
        }
    }
    
    var method: Method {
        switch self {
        case .trending:
            return .get
        }
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        switch self {
        case let .trending(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        ["Content-Type" : "application/json"]
    }
    
}
