//
//  MyAssetReader.swift
//  App
//
//  Created by Tomoya Hirano on 2020/02/17.
//

import Foundation
import CoreMedia

class MyAsset {
    enum MediaType {
        case video
    }
    
    init(url: URL) {
        
    }
    
    func tracks(withMediaType: MyAsset.MediaType) -> [MyAssetTrack] {
        []
    }
}

class MyAssetTrack {
    
}

class MyAssetReader {
    init(asset: MyAsset) throws {
        
    }
    
    func add(_ output: MyAssetReaderTrackOutput) {
        
    }
    
    func startReading() {
        
    }
}

class MyAssetReaderTrackOutput {
    init(track: MyAssetTrack, outputSettings: [String : Any]) {
        
    }
    
    func copyNextSampleBuffer() -> CMSampleBuffer? {
        nil
    }
}
