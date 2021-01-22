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
        static let defaultHeight = 100.f
    }
    
    private let player = AVPlayer(playerItem: nil).then {
        $0.isMuted = true
    }
    
    lazy var playerView = PlayerView(player: player).then {
        $0.playerLayer.videoGravity = .resize
        $0.backgroundColor = .random()
    }
    
    override func initialize() {
        self.hero.isEnabled = true
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(playerView)
        
        playerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeArea.top)
        }
    }
    
    func bind(reactor: DetailViewReactor) {
        reactor.state.map(\.id)
            .subscribe(onNext: { [weak self] id in
                self?.playerView.heroID = id
            }).disposed(by: disposeBag)
        
        reactor.state.map(\.ratio)
            .subscribe(onNext: { [weak self] ratio in
                guard let self = self else { return }
                self.playerView.snp.updateConstraints { make in
                    make.height.equalTo(self.view.snp.width).multipliedBy(ratio)
                }
            }).disposed(by: disposeBag)
            
    }
    
}

