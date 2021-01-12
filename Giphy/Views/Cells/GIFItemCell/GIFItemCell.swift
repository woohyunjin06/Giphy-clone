//
//  GIFItemCell.swift
//  Giphy
//
//  Created by 현진 on 2021/01/11.
//

import UIKit

class GIFItemCell: BaseCollectionViewCell<GIF> {
    
    let imageView = UIImageView().then {
        $0.backgroundColor = .blue
    }
    
    override func initialize() {
        contentView.addSubview(imageView)
    }
    
    override func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func bind(item: GIF) {
        super.bind(item: item)
        
    }
    
}
