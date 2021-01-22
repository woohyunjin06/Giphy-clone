//
//  GIFItemCell.swift
//  Giphy
//
//  Created by 현진 on 2021/01/11.
//

import UIKit
import AVKit

import Hero

class GIFItemCell: BaseCollectionViewCell<GIF> {
    
    private let player = AVPlayer(playerItem: nil).then {
        $0.isMuted = true
    }
    
    lazy var playerView = PlayerView(player: player).then {
        $0.playerLayer.videoGravity = .resize
    }
    
    let imageView = UIImageView().then {
        $0.backgroundColor = .random()
    }
    
    override func initialize() {
        contentView.addSubview(imageView)
        contentView.addSubview(playerView)
    }
    
    override func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        playerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
    override func bind(item: GIF) {
        super.bind(item: item)
        
        playerView.heroID = item.id
        if let videoURL = URL(string: item.images.image.mp4) {
            player.replaceCurrentItem(with: AVPlayerItem(url: videoURL))
        }
        registerNotification()
        player.play()
    }
      
    private func registerNotification() {
        NotificationCenter.default.rx
            .notification(.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
            .subscribe { [weak player] _ in
                player?.seek(to: CMTime.zero)
                player?.play()
            }.disposed(by: disposeBag)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        player.replaceCurrentItem(with: nil)
        player.pause()
    }
}
