//
//  APIKeyPlugin.swift
//  Giphy
//
//  Created by 현진 on 2021/01/10.
//

import Moya

struct APIKeyPlugin: PluginType {

    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        
        if let requestURL = request.url {
            var urlComponents = URLComponents(url: requestURL, resolvingAgainstBaseURL: false)
            if urlComponents?.queryItems?.contains { $0.name == "api_key" } == false {
                urlComponents?.queryItems?.append(URLQueryItem(name: "api_key", value: Consts.API_KEY))
            }
            request.url = try? urlComponents?.asURL()
        }

        return request
    }
}
