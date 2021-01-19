//
//  ViewControllerDependency.swift
//  Giphy
//
//  Created by 현진 on 2021/01/09.
//

import ReactorKit
import Resolver

extension Resolver {
    public static func registerViewControllers() {
        register { HomeViewController() }
            .resolveProperties { resolver, viewController in
                viewController.reactor = resolver.resolve() as HomeViewReactor
            }
    }
}
