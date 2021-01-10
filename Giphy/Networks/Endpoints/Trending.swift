//
//  Trending.swift
//  Giphy
//
//  Created by 현진 on 2021/01/10.
//

import Moya

enum Trending {
    case all
}

extension Trending: TargetType {
    var baseURL: URL {
        Server.baseURL(endpoint: "/gifs/trending")
    }
    
    var path: String {
        ""
    }
    
    var method: Method {
        .get
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        .requestPlain
    }
    
    var headers: [String : String]? {
        [
            "Content-Type" : "application/json"
        ]
    }
    
    
}
