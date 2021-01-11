//
//  ServiceDependency.swift
//  Giphy
//
//  Created by 현진 on 2021/01/09.
//

import Resolver

extension Resolver {
    public static func registerServices() {
        register { GIFsServiceImpl() as GIFsService }
    }
}
