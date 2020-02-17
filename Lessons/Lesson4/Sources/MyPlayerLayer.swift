//
//  MyPlayerLayer.swift
//  App
//
//  Created by Tomoya Hirano on 2020/02/17.
//

import UIKit
import AVFoundation

class MyPlayerLayer: MySampleBufferDisplayLayer, MyPlayerDelegate {
    init(player: MyPlayer?) {
        super.init()
        player?.delegate = self
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    func didOutput(_ sampleBuffer: CMSampleBuffer) {
        enqueue(sampleBuffer)
    }
}
