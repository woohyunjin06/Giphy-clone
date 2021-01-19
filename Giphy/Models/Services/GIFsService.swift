//
//  GIFsService.swift
//  Giphy
//
//  Created by 현진 on 2021/01/10.
//

import Resolver
import RxSwift

protocol GIFsService {
    func trending(limit: Int, offset: Int) -> Single<List<GIF>>
}

class GIFsServiceImpl: GIFsService {
    
    private let networking: Networking<GIFs>
    private let decoder: JSONDecoder
    init(networking: Networking<GIFs>) {
        self.networking = networking
        self.decoder = JSONDecoder()
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func trending(limit: Int, offset: Int) -> Single<List<GIF>> {
        let parameters: [String : Any] = [
            "limit": limit,
            "offset": offset
        ]
        return networking.request(.trending(parameters))
            .map(List<GIF>.self)
    }
    
    
}
