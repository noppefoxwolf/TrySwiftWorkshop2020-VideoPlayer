//
//  MyPlayer.swift
//  App
//
//  Created by Tomoya Hirano on 2020/02/17.
//

import UIKit
import AVFoundation
import CoreMedia

internal protocol MyPlayerDelegate: class {
    func didOutput(_ sampleBuffer: CMSampleBuffer)
}

class MyPlayer {
    private let reader: AVAssetReader
    private let output: AVAssetReaderOutput
    private var displayLink: CADisplayLink!
    weak var delegate: MyPlayerDelegate? = nil
    
    init(url: URL) {
        let asset = AVAsset(url: url)
        reader = try! AVAssetReader(asset: asset)
        output = AVAssetReaderTrackOutput(track: asset.tracks(withMediaType: .video)[0], outputSettings: nil)
        reader.add(output)
        reader.startReading()
        
        displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink.preferredFramesPerSecond = 30
        displayLink.add(to: .main, forMode: .common)
    }
    
    var rate: Double = 0.0
    
    func play() {
        rate = 1
    }
    
    func pause() {
        rate = 0
    }
    
    @objc private func update() {
        guard rate > 0 else { return }
        guard let sampleBuffer = output.copyNextSampleBuffer() else { return }
        delegate?.didOutput(sampleBuffer)
    }
}
