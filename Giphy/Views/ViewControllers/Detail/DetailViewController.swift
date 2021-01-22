//
//  DetailViewController.swift
//  Giphy
//
//  Created by 현진 on 2021/01/20.
//

import UIKit
import AVKit

import Hero
import ReactorKit
import RxDataSources
import RxViewController

class DetailViewController: BaseViewController, View {
    
    fileprivate struct Dimens {
        
    }
    
    private let player = AVPlayer(playerItem: nil).then {
        $0.isMuted = true
    }
    
    lazy var playerView = PlayerView(player: player).then {
        $0.playerLayer.videoGravity = .resize
    }
    
    let imageView: UIImageView
    private let ratio: Float
    
    init(ratio: Float, snapshot: UIImage?) {
        self.ratio = ratio
        self.imageView = UIImageView().then {
            $0.image = snapshot
        }
    }
    
    required convenience init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func initialize() {
        self.hero.isEnabled = true
        self.view.backgroundColor = .systemBackground
        
        view.addSubview(imageView)
        view.addSubview(playerView)
    }
    
    override func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeArea.top)
            make.height.equalTo(self.view.snp.width).multipliedBy(ratio)
        }
        playerView.snp.makeConstraints { make in
            make.edges.equalTo(imageView)
        }
    }
    
    func bind(reactor: DetailViewReactor) {
        reactor.state.map(\.id)
            .subscribe(onNext: { [weak self] id in
                self?.playerView.heroID = id
            }).disposed(by: disposeBag)
            
    }
    
}

