//
//  DependencyRoot.swift
//  Giphy
//
//  Created by 현진 on 2021/01/09.
//

import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        registerNetworkings()
        registerServices()
        registerViewReactors()
        registerViewControllers()
    }
}
