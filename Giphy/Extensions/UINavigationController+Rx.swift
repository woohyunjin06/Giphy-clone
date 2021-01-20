//
//  UINavigationController+Rx.swift
//  Giphy
//
//  Created by 현진 on 2021/01/20.
//

import UIKit

import RxCocoa
import RxSwift

extension Reactive where Base: UINavigationController {
    
    func pushViewController(animated: Bool) -> Binder<UIViewController> {
        Binder(base) { navigationController, viewController in
            navigationController.pushViewController(viewController, animated: animated)
        }
    }
    
}
