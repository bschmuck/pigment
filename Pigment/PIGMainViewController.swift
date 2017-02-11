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
    
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var cameraIcon: UIButton!
    @IBOutlet weak var colorView: UIView!
    let captureSession = AVCaptureSession()
    let stillImageOutput = AVCaptureStillImageOutput()
    var error: NSError?
    
    let colorNamer = DBColorNames()
    
    @IBOutlet weak var color1Label: UILabel!
    @IBOutlet weak var color2Label: UILabel!
    @IBOutlet weak var mainColorLabel: UILabel!
    @IBOutlet weak var color3Label: UILabel!
    @IBOutlet weak var color4Label: UILabel!
    @IBOutlet weak var color1NameLabel: UILabel!
    @IBOutlet weak var color2NameLabel: UILabel!
    @IBOutlet weak var mainColorNameLabel: UILabel!
    
    @IBOutlet weak var color3NameLabel: UILabel!
    @IBOutlet weak var color4NameLabel: UILabel!
    @IBOutlet weak var modeLabel: UILabel!
    @IBOutlet weak var color1View: UIView!
    @IBOutlet weak var color2View: UIView!
    @IBOutlet weak var color3View: UIView!
    @IBOutlet weak var color4View: UIView!
    @IBOutlet weak var menuButton: UIButton!
    var showingInfo = false
    var showingCamera = false
    var textIsBlack = false

    override func viewDidLoad() {
        super.viewDidLoad()
        var labelVal = ""
        
        color1Label.isHidden = true
        color2Label.isHidden = true
        color3Label.isHidden = true
        color4Label.isHidden = true
        mainColorLabel.isHidden = true
        
        color1NameLabel.isHidden = true
        color2NameLabel.isHidden = true
        color3NameLabel.isHidden = true
        color4NameLabel.isHidden = true
        mainColorNameLabel.isHidden = true
        
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
        shareButton.addTarget(self, action: #selector(shareColor), for: .touchUpInside)
        
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
            color1NameLabel.isHidden = true
            color2NameLabel.isHidden = true
            color3NameLabel.isHidden = true
            color4NameLabel.isHidden = true
            mainColorNameLabel.isHidden = true
        } else {
            self.showingInfo = true
            self.mainColorLabel.isHidden = false
            self.color1Label.isHidden = false
            self.color2Label.isHidden = false
            self.color3Label.isHidden = false
            self.color4Label.isHidden = false
            color1NameLabel.isHidden = false
            color2NameLabel.isHidden = false
            color3NameLabel.isHidden = false
            color4NameLabel.isHidden = false
            mainColorNameLabel.isHidden = false
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
        
        PIGSelection.shared.red = Double(avgRed)
        PIGSelection.shared.green = Double(avgGreen)
        PIGSelection.shared.blue = Double(avgBlue)
        PIGSelection.shared.alpha = Double(avgAlpha)
        
        let colorVal  = UIColor(colorLiteralRed: Float(avgRed), green: Float(avgGreen), blue: Float(avgBlue), alpha: avgAlpha)
        let color1 = PIGColorManager.getColor1(color: colorVal, mode: PIGSelection.shared.selectedMode)
        let color2 = PIGColorManager.getColor2(color: colorVal, mode: PIGSelection.shared.selectedMode)
        let color3 = PIGColorManager.getColor3(color: colorVal, mode: PIGSelection.shared.selectedMode)
        let color4 = PIGColorManager.getColor4(color: colorVal, mode: PIGSelection.shared.selectedMode)
        
        PIGSelection.shared.currentColor = colorVal
        
        color1NameLabel.text = colorNamer.name(for: color1)
        color2NameLabel.text = colorNamer.name(for: color2)
        color3NameLabel.text = colorNamer.name(for: color3)
        color4NameLabel.text = colorNamer.name(for: color4)
        mainColorNameLabel.text = colorNamer.name(for: colorVal)
        
        let color1Vals = PIGColorManager.getRGBA(color: color1)
        let color2Vals = PIGColorManager.getRGBA(color: color2)
        let color3Vals = PIGColorManager.getRGBA(color: color3)
        let color4Vals = PIGColorManager.getRGBA(color: color4)
        
        let selection = PIGSelection.shared
        var threshhold = 105
        var bgDelta = (Int((selection.red * 0.299) + (selection.green * 0.587) + (selection.blue * 0.114)))
        if 255 - bgDelta < threshhold  && !textIsBlack {
            textIsBlack = true
            self.mainColorLabel.textColor = UIColor.black
            self.color1Label.textColor = UIColor.black
            self.color2Label.textColor = UIColor.black
            self.color3Label.textColor = UIColor.black
            self.color4Label.textColor = UIColor.black
            color1NameLabel.textColor = UIColor.black
            color2NameLabel.textColor = UIColor.black
            color3NameLabel.textColor = UIColor.black
            color4NameLabel.textColor = UIColor.black
            mainColorNameLabel.textColor = UIColor.black
        } else if textIsBlack {
            textIsBlack = false
            self.mainColorLabel.textColor = UIColor.white
            self.color1Label.textColor = UIColor.white
            self.color2Label.textColor = UIColor.white
            self.color3Label.textColor = UIColor.white
            self.color4Label.textColor = UIColor.white
            color1NameLabel.textColor = UIColor.white
            color2NameLabel.textColor = UIColor.white
            color3NameLabel.textColor = UIColor.white
            color4NameLabel.textColor = UIColor.white
            mainColorNameLabel.textColor = UIColor.white
        }
        
        
        DispatchQueue.main.async {
            self.mainColorLabel.text = "r: \(255*avgRed), g: \(255*avgGreen), b: \(255*avgBlue), a: \(avgAlpha)"
            self.color1Label.text = "r: \(255*color1Vals.red), g: \(255*color1Vals.green), b: \(255*color1Vals.blue), a: \(color1Vals.alpha)"
            self.color2Label.text = "r: \(255*color2Vals.red), g: \(255*color2Vals.green), b: \(255*color2Vals.blue), a: \(color2Vals.alpha)"
            self.color3Label.text = "r: \(255*color3Vals.red), g: \(255*color3Vals.green), b: \(255*color3Vals.blue), a: \(color3Vals.alpha)"
            self.color4Label.text = "r: \(255*color4Vals.red), g: \(255*color4Vals.green), b: \(255*color4Vals.blue), a: \(color4Vals.alpha)"
            self.colorView.backgroundColor = colorVal
            self.color1View.backgroundColor = color1
            self.color2View.backgroundColor = color2
            self.color3View.backgroundColor = color3
            self.color4View.backgroundColor = color4
        }
    }
    
    func shareColor() {
        let shareContent = "\(self.modeLabel.text!):\n\(self.mainColorLabel.text!)\n\(self.color1Label.text!)\n\(self.color2Label.text!)\n\(self.color3Label.text!)\n\(self.color4Label.text!)\n"
        
        let colors = [self.color1View.backgroundColor!, self.color2View.backgroundColor!, self.colorView.backgroundColor!, self.color3View.backgroundColor!, self.color4View.backgroundColor!]
        
        let image = PIGColorManager.imageWithColors(colors: colors)
        
        DispatchQueue.main.async {
            let activityViewController = UIActivityViewController(activityItems: [shareContent as NSString, image as UIImage], applicationActivities: nil)
            
            self.present(activityViewController, animated: true, completion: {})
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

