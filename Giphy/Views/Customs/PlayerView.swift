//
//  PlayerView.swift
//  Giphy
//
//  Created by 현진 on 2021/01/18.
//

import UIKit
import AVKit
import AVFoundation

class PlayerView: UIView {
    
    init(player: AVPlayer) {
        super.init(frame: .zero)
        playerLayer.player = player
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override static var layerClass: AnyClass {
        return AVPlayerLayer.self
    }

    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    
    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
    }
}
