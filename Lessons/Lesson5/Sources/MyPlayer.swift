//
//  MyPlayer.swift
//  App
//
//  Created by Tomoya Hirano on 2020/02/17.
//

import UIKit
import CoreMedia

internal protocol MyPlayerDelegate: class {
    func didOutput(_ sampleBuffer: CMSampleBuffer)
}

class MyPlayer {
    private let reader: MyAssetReader
    private let output: MyAssetReaderTrackOutput
    private var displayLink: CADisplayLink!
    weak var delegate: MyPlayerDelegate? = nil
    
    init(url: URL) {
        let outputSettings: [String : Any] = [kCVPixelBufferPixelFormatTypeKey as String : kCVPixelFormatType_32BGRA, kCVPixelBufferMetalCompatibilityKey  as String : true]
        let asset = MyAsset(url: url)
        reader = try! MyAssetReader(asset: asset)
        
        output = MyAssetReaderTrackOutput(track: asset.tracks(withMediaType: .video)[0], outputSettings: outputSettings)
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
