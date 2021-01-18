//
//  HomeViewController.swift
//  Giphy
//
//  Created by 현진 on 2021/01/09.
//

import UIKit

import CollectionViewWaterfallLayout
import ReactorKit
import RxDataSources
import RxViewController

class HomeViewController: BaseViewController, View {
    
    private let dataSource: RxCollectionViewSectionedReloadDataSource<GIFListViewSection>
    override init() {
        self.dataSource = Self.factoryDataSource()
    }
    
    // MARK: - Consts
    fileprivate struct Dimens {
        static let itemSpacing = 4.f
    }
    
    // MARK: - UI
    
    let collectionViewLayout = CollectionViewWaterfallLayout().then {
        $0.minimumColumnSpacing = 6
        $0.minimumInteritemSpacing = 6
    }
    
    lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: collectionViewLayout
    ).then {
        $0.contentInset = .zero
        $0.backgroundColor = .clear
        $0.register(GIFItemCell.self)
        $0.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    static private func factoryDataSource() -> RxCollectionViewSectionedReloadDataSource<GIFListViewSection> {
        return .init { dataSource, collectionView, indexPath, sectionItem in
            switch sectionItem {
            case let .gif(gif):
                let cell = collectionView.dequeue(GIFItemCell.self, for: indexPath)
                cell.bind(item: gif) 
                return cell
                
            }
        }
    }
    
    // MARK: - View configuration
    override func initialize() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(collectionView)
        
    }
    
    override func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func bind(reactor: HomeViewReactor) {
        self.rx.viewDidLoad
            .map { Reactor.Action.refresh }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map(\.sections)
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        
    }
    
}

extension HomeViewController: CollectionViewWaterfallLayoutDelegate {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout: UICollectionViewLayout,
        ratioForItemAtIndexPath indexPath: IndexPath
    ) -> CGFloat {
        switch dataSource[indexPath as IndexPath] {
        case let .gif(gif):
            let image = gif.images.image

            
            
            guard let imageHeight = Int(image.height),
                  let imageWidth = Int(image.width)
            else {
                return 1
            }


            return CGFloat(imageHeight) / CGFloat(imageWidth)
        }
    }
}
