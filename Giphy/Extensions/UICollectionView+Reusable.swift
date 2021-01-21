//
//  UICollectionView+Reusable.swift
//  Giphy
//
//  Created by 현진 on 2021/01/11.
//

import UIKit

import RxSwift

extension UICollectionReusableView: Reusable { }

extension UICollectionView {
    
    func register<T>(_ cellType: T.Type) where T: UICollectionViewCell {
        self.register(cellType, forCellWithReuseIdentifier: cellType.reuseID)
    }
    
    func register<T>(_ viewType: T.Type, forSupplementaryViewOfKind elementKind: String) where T: UICollectionReusableView {
        self.register(viewType, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: viewType.reuseID)
    }
    
    func dequeue<T>(_ cellType: T.Type, for indexPath: IndexPath) -> T where T: UICollectionViewCell {
        return self.dequeueReusableCell(withReuseIdentifier: cellType.reuseID, for: indexPath) as! T
    }
    
    func dequeue<T>(
        _ viewType: T.Type,
        ofKind elementKind: String,
        for indexPath: IndexPath
    ) -> T where T: UICollectionReusableView {
        return self.dequeueReusableSupplementaryView(
            ofKind: elementKind,
            withReuseIdentifier: T.reuseID,
            for: indexPath
        ) as! T
    }
    
}

extension Reactive where Base: UICollectionView {
    func items<S: Sequence, Cell: UICollectionViewCell, O : ObservableType>(cellType: Cell.Type)
    -> (_ source: O)
    -> (_ configureCell: @escaping (Int, S.Iterator.Element, Cell) -> Void)
    -> Disposable where O.Element == S {
        items(cellIdentifier: Cell.reuseID, cellType: cellType)
    }
}
