//
//  MyPlayerViewController.swift
//  App
//
//  Created by Tomoya Hirano on 2020/02/17.
//

import UIKit
import AVKit

class MyPlayerViewController: UIViewController {
    private var playerLayer: MyPlayerLayer!
    var player: MyPlayer? = nil
    private let button: PlaybackButton = PlaybackButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup UI
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: 20)
        ])
        button.isPlaying = false
        
        playerLayer = MyPlayerLayer(player: player)
        view.layer.addSublayer(playerLayer)
        playerLayer.frame = view.bounds
        
        // setup control
        button.onTap = {
            guard let player = self.player else { return }
            if player.rate > 0 {
                player.pause()
                self.button.isPlaying = false
            } else {
                player.play()
                self.button.isPlaying = true
            }
        }
    }
}

