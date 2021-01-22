//
//  HomeViewController.swift
//  Giphy
//
//  Created by 현진 on 2021/01/09.
//

import UIKit

import ReactorKit
import Resolver
import RxDataSources
import RxViewController

class HomeViewController: BaseViewController, View {
    
    private let dataSource: RxCollectionViewSectionedAnimatedDataSource<GIFListViewSection>
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
    
    let refreshControl = UIRefreshControl()
    
    lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: collectionViewLayout
    ).then {
        $0.refreshControl = refreshControl
        $0.contentInset = .zero
        $0.backgroundColor = .clear
        $0.register(GIFItemCell.self)
        $0.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    static private func factoryDataSource() -> RxCollectionViewSectionedAnimatedDataSource<GIFListViewSection> {
        return .init { dataSource, collectionView, indexPath, sectionItem in
            switch sectionItem {
            case let .gif(gif):
                let cell = collectionView.dequeue(GIFItemCell.self, for: indexPath)
                cell.heroID = gif.id
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
        
        collectionView.rx.reachBottom
            .map { Reactor.Action.loadMore }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map(\.sections)
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        reactor.state.map(\.isRefreshing)
            .bind(to: refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        let imageSnapshot = collectionView.rx.itemSelected
            .compactMap { [weak self] in self?.imageSnapshot(for: $0) }
        
        collectionView.rx.modelSelected(GIFListViewSectionItem.self)
            .withLatestFrom(imageSnapshot) { [weak self] model, snapshot in
                self?.viewController(for: model, with: snapshot)
            }.compactMap { $0 }
            .bind(onNext: { [weak self] viewController in
                self?.navigationController?.pushViewController(viewController, animated: true)
            })
            .disposed(by: disposeBag)
        
    }
    
    private func imageSnapshot(for indexPath: IndexPath) -> UIImage? {
        (self.collectionView.cellForItem(at: indexPath) as? GIFItemCell)?.imageSnapshot
    }
    
    private func viewController(for model: GIFListViewSectionItem, with snapshot: UIImage?) -> UIViewController {
        switch model {
        case let .gif(gif):
            let viewController = DetailViewController(
                ratio: Float(gif.images.image.ratio),
                snapshot: snapshot
            )
            viewController.reactor = Resolver.resolve(
                args: ["id" : gif.id]
            ) as DetailViewReactor
            return viewController
        }
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
            return gif.images.image.ratio
        }
    }
}
