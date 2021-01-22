//
//  UIView+SafeArea.swift
//  Giphy
//
//  Created by 현진 on 2021/01/22.
//

import UIKit

import SnapKit

extension UIView {
    var safeArea: ConstraintBasicAttributesDSL {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.snp
        }
        return self.snp
    }
}
