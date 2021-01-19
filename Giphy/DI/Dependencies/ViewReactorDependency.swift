//
//  ViewReactorDependency.swift
//  Giphy
//
//  Created by 현진 on 2021/01/09.
//

import Resolver

extension Resolver {
    public static func registerViewReactors() {
        register { HomeViewReactor(gifsService: $0.resolve()) }
    }
}
