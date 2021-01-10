//
//  Client.swift
//  Giphy
//
//  Created by 현진 on 2021/01/10.
//

import Moya
import RxSwift

class Client<Target: TargetType>: MoyaProvider<Target> {

    func request(_ token: Target) -> Single<Response> {
        super.rx.request(token)
            .filterSuccessfulStatusCodes()
            .catchError {error -> Single<Response> in
                if case let MoyaError.statusCode(response) = error {
                    guard let body = try? JSONDecoder().decode(ResponseBody<NoData>.self, from: response.data) else {
                        return .error(ClientError.statusErrorUndecodable(statusCode: response.statusCode))
                    }
                    return .error(ClientError.statusError(statusCode: response.statusCode, message: body.meta.msg))
                }
                return .error(ClientError.unhandledError(error))
            }
    }
    
} 
