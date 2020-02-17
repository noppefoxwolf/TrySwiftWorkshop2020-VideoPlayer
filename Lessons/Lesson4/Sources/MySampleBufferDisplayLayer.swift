//
//  MySampleBufferDisplayLayer.swift
//  App
//
//  Created by Tomoya Hirano on 2020/02/17.
//

import QuartzCore
import CoreMedia
import MetalKit

open class MySampleBufferDisplayLayer: CAMetalLayer {
    private var commandQueue: MTLCommandQueue? = nil
    private var textureCache: CVMetalTextureCache? = nil
    
    public override init() {
        super.init()
        device = MTLCreateSystemDefaultDevice()!
        pixelFormat = .bgra8Unorm
        framebufferOnly = true
        commandQueue = device?.makeCommandQueue()
        CVMetalTextureCacheCreate(kCFAllocatorDefault, nil, device!, nil, &textureCache)
    }
    
    required public init?(coder: NSCoder) { fatalError() }
    
    func enqueue(_ sampleBuffer: CMSampleBuffer) {
        let pixelBuffer = sampleBuffer.imageBuffer!
        let width = CVPixelBufferGetWidth(pixelBuffer)
        let height = CVPixelBufferGetHeight(pixelBuffer)
        var cvMetalTexture: CVMetalTexture? = nil
        CVMetalTextureCacheCreateTextureFromImage(kCFAllocatorDefault, textureCache!, pixelBuffer, nil, .bgra8Unorm, width, height, 0, &cvMetalTexture)
        let texture = CVMetalTextureGetTexture(cvMetalTexture!)
        
        
        let drawable = nextDrawable()!
        let commandBuffer = commandQueue!.makeCommandBuffer()!
        
        let vertexData: [Float] = [
          -1.0, -1.0, 0, 1,
          1.0, -1.0, 0, 1,
          -1.0,  1.0, 0, 1,
          1.0,  1.0, 0, 1,
        ]
        let size = vertexData.count * MemoryLayout<Float>.size
        let vertexBuffer = device!.makeBuffer(bytes: vertexData, length: size)
        
        let texCoordinateData: [Float] = [0,1,
                                          1,1,
                                          0,0,
                                          1,0]
        let texCoordinateDataSize = texCoordinateData.count * MemoryLayout<Float>.size
        let texCoordBuffer = device!.makeBuffer(bytes: texCoordinateData, length: texCoordinateDataSize)!
        
        let pipelineDesc = MTLRenderPipelineDescriptor()
        let libraty = device!.makeDefaultLibrary()!
        pipelineDesc.vertexFunction   = libraty.makeFunction(name: "vertexShader")!
        pipelineDesc.fragmentFunction = libraty.makeFunction(name: "fragmentShader")!
        pipelineDesc.colorAttachments[0].pixelFormat = .bgra8Unorm
        let pipelineState = try! device!.makeRenderPipelineState(descriptor: pipelineDesc)
        
        let renderDesc = MTLRenderPassDescriptor()
        renderDesc.colorAttachments[0].texture = drawable.texture
        renderDesc.colorAttachments[0].loadAction = .clear
        
        let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderDesc)!
        renderEncoder.setRenderPipelineState(pipelineState)
        renderEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderEncoder.setVertexBuffer(texCoordBuffer, offset: 0, index: 1)
        renderEncoder.setFragmentTexture(texture!, index: 0)
        renderEncoder.drawPrimitives(type: .triangleStrip, vertexStart: 0, vertexCount: 4)
        renderEncoder.endEncoding()
        
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
}
