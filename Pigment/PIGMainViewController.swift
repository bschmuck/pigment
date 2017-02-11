//
//  ViewController.swift
//  Pigment
//
//  Created by Brandon Schmuck on 2/10/17.
//  Copyright © 2017 Brandon Schmuck. All rights reserved.
//

import UIKit
import AVFoundation
import SWRevealViewController

class PIGMainViewController: UIViewController, UIImagePickerControllerDelegate, AVCaptureVideoDataOutputSampleBufferDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var showInfo: UIButton!
    @IBOutlet weak var menuButtonYConstraint: NSLayoutConstraint!
    @IBOutlet weak var camFrame: UIView!
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    
    @IBOutlet weak var cameraIcon: UIButton!
    @IBOutlet weak var colorView: UIView!
    let captureSession = AVCaptureSession()
    let stillImageOutput = AVCaptureStillImageOutput()
    var error: NSError?
    
    @IBOutlet weak var color1Label: UILabel!
    @IBOutlet weak var color2Label: UILabel!
    @IBOutlet weak var mainColorLabel: UILabel!
    @IBOutlet weak var color3Label: UILabel!
    @IBOutlet weak var color4Label: UILabel!
    
    @IBOutlet weak var modeLabel: UILabel!
    @IBOutlet weak var color1View: UIView!
    @IBOutlet weak var color2View: UIView!
    @IBOutlet weak var color3View: UIView!
    @IBOutlet weak var color4View: UIView!
    @IBOutlet weak var menuButton: UIButton!
    var showingInfo = false
    var showingCamera = false

    override func viewDidLoad() {
        super.viewDidLoad()
        var labelVal = ""
        
        color1Label.isHidden = true
        
        switch PIGSelection.shared.selectedMode {
            
        case .analagous:
            labelVal = "Analagous"
        case .shade:
            labelVal = "Shade"
        case .compound:
            labelVal = "Compound"
        case .complimentary:
            labelVal = "Complimentary"
        case .triade:
            labelVal = "Triade"
            
        }
        
        showInfo.addTarget(self, action: #selector(toggleInfo), for: .touchUpInside)
        cameraIcon.addTarget(self, action: #selector(toggleCamera), for: .touchUpInside)
        
        modeLabel.text = labelVal
        
        if self.revealViewController() != nil {
            menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: {
            granted in
            if granted {
                
                self.captureSession.sessionPreset = AVCaptureSessionPresetPhoto
                
                let backCamera = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
                
                do
                {
                    let input = try AVCaptureDeviceInput(device: backCamera)
                    
                    self.captureSession.addInput(input)
                }
                catch
                {
                    print("can't access camera")
                    return
                }
                
                // although we don't use this, it's required to get captureOutput invoked
//                let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
//                self.view.layer.addSublayer(previewLayer!)
                
                let videoOutput = AVCaptureVideoDataOutput()
                
                videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "buffer_queue"))
                if self.captureSession.canAddOutput(videoOutput) {
                    self.captureSession.addOutput(videoOutput)
                }
                
                self.videoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
                self.videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
                self.videoPreviewLayer?.frame = self.camFrame.frame
                self.view.layer.addSublayer(self.videoPreviewLayer!)
                self.videoPreviewLayer?.isHidden = true
                
                self.captureSession.startRunning()
            } else {
            }
        })

    }
    
    var counter = 0;
    let numVals: Float = 20;
    
    var prevVals = Array<(red: Float?, green: Float?, blue: Float?, alpha: Float?)>()
    
    func toggleCamera() {
        if self.showingCamera {
            self.videoPreviewLayer?.isHidden = true
            self.showingCamera = false
        } else {
            self.videoPreviewLayer?.isHidden = false
            self.showingCamera = true
        }
    }
    
    func toggleInfo() {
        if self.showingInfo {
             self.showingInfo = false
             self.mainColorLabel.isHidden = true
            self.color1Label.isHidden = true
            self.color2Label.isHidden = true
            self.color3Label.isHidden = true
            self.color4Label.isHidden = true
        } else {
            self.showingInfo = true
            self.mainColorLabel.isHidden = false
            self.color1Label.isHidden = false
            self.color2Label.isHidden = false
            self.color3Label.isHidden = false
        }
    }
    
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
        
        let colorVal  = UIColor(colorLiteralRed: Float(avgRed), green: Float(avgGreen), blue: Float(avgBlue), alpha: avgAlpha)
        let color1 = PIGColorManager.getColor1(color: colorVal, mode: PIGSelection.shared.selectedMode)
        let color2 = PIGColorManager.getColor2(color: colorVal, mode: PIGSelection.shared.selectedMode)
        let color3 = PIGColorManager.getColor3(color: colorVal, mode: PIGSelection.shared.selectedMode)
        let color4 = PIGColorManager.getColor4(color: colorVal, mode: PIGSelection.shared.selectedMode)
        
        
        let color1Vals = PIGColorManager.getRGBA(color: color1)
        let color2Vals = PIGColorManager.getRGBA(color: color2)
        let color3Vals = PIGColorManager.getRGBA(color: color3)
        let color4Vals = PIGColorManager.getRGBA(color: color4)
        
        DispatchQueue.main.async {
            self.mainColorLabel.text = "r: \(avgRed), g: \(avgGreen), b: \(avgBlue), a: \(avgAlpha)"
            self.color1Label.text = "r: \(color1Vals.red), g: \(color1Vals.green), b: \(color1Vals.blue), a: \(color1Vals.alpha)"
            self.color2Label.text = "r: \(color2Vals.red), g: \(color2Vals.green), b: \(color2Vals.blue), a: \(color2Vals.alpha)"
            self.color3Label.text = "r: \(color3Vals.red), g: \(color3Vals.green), b: \(color3Vals.blue), a: \(color3Vals.alpha)"
            self.color4Label.text = "r: \(color4Vals.red), g: \(color4Vals.green), b: \(color4Vals.blue), a: \(color4Vals.alpha)"
            self.colorView.backgroundColor = colorVal
            self.color1View.backgroundColor = color1
            self.color2View.backgroundColor = color2
            self.color3View.backgroundColor = color3
            self.color4View.backgroundColor = color4
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

