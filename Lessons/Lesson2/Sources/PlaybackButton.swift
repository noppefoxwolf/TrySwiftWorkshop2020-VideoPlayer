//
//  PlaybackButton.swift
//  App
//
//  Created by Tomoya Hirano on 2020/02/17.
//

import UIKit

class PlaybackButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        tintColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    @objc private func didTap(_ sender: UIButton) {
        onTap()
    }
    
    var onTap: () -> Void = {}
    
    var isPlaying: Bool = false {
        didSet {
            if isPlaying {
                setImage(UIImage(systemName: "pause.fill"), for: .normal)
            } else {
                setImage(UIImage(systemName: "play.fill"), for: .normal)
            }
        }
    }
}
