//
//  ViewController.swift
//  Pigment
//
//  Created by Brandon Schmuck on 2/10/17.
//  Copyright © 2017 Brandon Schmuck. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIImagePickerControllerDelegate, AVCaptureVideoDataOutputSampleBufferDelegate, UINavigationControllerDelegate {
    
    let captureSession = AVCaptureSession()
    let stillImageOutput = AVCaptureStillImageOutput()
    var error: NSError?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: {
            granted in
            if granted {
                
                let captureSession = AVCaptureSession()
                captureSession.sessionPreset = AVCaptureSessionPresetPhoto
                
                let backCamera = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
                
                do
                {
                    let input = try AVCaptureDeviceInput(device: backCamera)
                    
                    captureSession.addInput(input)
                }
                catch
                {
                    print("can't access camera")
                    return
                }
                
                // although we don't use this, it's required to get captureOutput invoked
                let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                self.view.layer.addSublayer(previewLayer!)
                
                let videoOutput = AVCaptureVideoDataOutput()
                
                videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "buffer_queue"))
                if captureSession.canAddOutput(videoOutput) {
                    captureSession.addOutput(videoOutput)
                }
                
                captureSession.startRunning()
            } else {
            }
        })

    }
    
    var counter = 0;
    let numVals: Float = 20;
    
    var prevVals = Array<(red: Float?, green: Float?, blue: Float?, alpha: Float?)>()
    
    
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
        let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
        let image = CIImage(cvPixelBuffer: pixelBuffer!)
        let rgba = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: 4)
        let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let info = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context: CGContext = CGContext(data: rgba, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: info.rawValue)!
        
        let ciContext:CIContext = CIContext.init(options: nil)
        let cgImage = ciContext.createCGImage(image, from: image.extent)
        context.draw(cgImage!, in: CGRect(x: 0, y: 0, width: 1, height: 1))
        
//        let cameraConstant = CGFloat(0.15)
        
//        if rgba[3] > 0 {
//            
//            let alpha: CGFloat = CGFloat(rgba[3]) / 255.0
//            let multiplier: CGFloat = alpha / 255.0
//            let red = CGFloat(rgba[0]) * multiplier
//            let green = CGFloat(rgba[1]) * multiplier
//            let blue = CGFloat(rgba[2]) * multiplier
//            
//        } else {
            let red = CGFloat(rgba[0]) / 255.0
            let green = CGFloat(rgba[1]) / 255.0
            let blue = CGFloat(rgba[2]) / 255.0
            let alpha: CGFloat = CGFloat(rgba[3]) / 255.0
        
            prevVals.insert((red: Float(red), green: Float(green), blue: Float(blue), alpha: Float(alpha)), at: counter % Int(numVals))
        
            counter += 1

        var avgRed: Float = 0.0
        var avgGreen: Float = 0.0
        var avgBlue: Float = 0.0
        var avgAlpha: Float = 0.0
        
        for i in 0..<Int(numVals) {
            if i < prevVals.count {
                let color = prevVals[i]
                if let red = color.red, let green = color.green, let blue = color.blue, let alpha = color.alpha {
                    avgRed += red
                    avgGreen += green
                    avgBlue += blue
                    avgAlpha += alpha
                }
            }
            
        }
        
        avgRed /= numVals
        avgGreen /= numVals
        avgBlue /= numVals
        avgAlpha /= numVals
        
        DispatchQueue.main.async {
            self.view.backgroundColor = UIColor(colorLiteralRed: Float(avgRed), green: Float(avgGreen), blue: Float(avgBlue), alpha: avgAlpha)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

