//
//  UIScrollView+Rx.swift
//  Giphy
//
//  Created by 현진 on 2021/01/18.
//

import UIKit

import RxCocoa
import RxSwift

extension Reactive where Base: UIScrollView {
    var reachBottom: ControlEvent<Void> {
        ControlEvent(
            events: contentOffset
                .map { $0.y }
                .filter { [weak base] contentOffsetY in
                    guard let base = base else { return false }
                    return base.frame.size.height + contentOffsetY + base.frame.size.height/2 > base.contentSize.height
                }.map { _ in Void() }
        )
    }
}
