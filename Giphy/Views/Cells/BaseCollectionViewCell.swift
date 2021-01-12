//
//  BaseCollectionViewCell.swift
//  Giphy
//
//  Created by 현진 on 2021/01/11.
//

import UIKit

import RxSwift

class BaseCollectionViewCell<Item>: UICollectionViewCell {
    
    var disposeBag = DisposeBag()
    var item: Item? = nil
    
    // MARK: - Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
        setupConstraints()
    }
    
    required convenience init?(coder: NSCoder) {
        self.init(frame: .zero)
    }
    
    // MARK: - Override
    func initialize() {}
    func setupConstraints() {}
    func bind(item: Item) {
        self.item = item
    }
    
    // MARK: - Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
    }
    
}
