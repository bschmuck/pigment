//
//  PIGColorManager.swift
//  Pigment
//
//  Created by Brandon Schmuck on 2/10/17.
//  Copyright © 2017 Brandon Schmuck. All rights reserved.
//

import UIKit
import EDColor


enum PIGMode {
    case complimentary
    case triade
    case analagous
    case shade
    case compound
}

class PIGColorManager: NSObject {
    
    class func getRGBA(color: UIColor) -> (red: Float, green: Float, blue: Float, alpha: Float) {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (red: Float(red), green: Float(green), blue: Float(blue), alpha: Float(alpha))
    }
    
    //Returns a complementary color of the given color
    class func getColor1(color: UIColor, mode: PIGMode) -> UIColor {
        switch mode {
            
        case .complimentary:
            
            var hue: CGFloat = 0.0
            var saturation: CGFloat = 0.0
            var lightness: CGFloat = 0.0
            var alpha: CGFloat = 0.0
            color.getHue(&hue, saturation: &saturation, lightness: &lightness, alpha: &alpha)
            
            saturation -= 0.04
            lightness -= 0.17
            return UIColor(hue: hue, saturation: saturation, lightness: lightness, alpha: alpha)
        case .analagous:
            var hue: CGFloat = 0.0
            var saturation: CGFloat = 0.0
            var lightness: CGFloat = 0.0
            var alpha: CGFloat = 0.0
            color.getHue(&hue, saturation: &saturation, lightness: &lightness, alpha: &alpha)
            
            hue += 0.305555555555
            saturation -= 0.20
            lightness -= 0.12
            
            return UIColor(hue: hue, saturation: saturation, lightness: lightness, alpha: alpha)
            
        case .triade:
            return UIColor.red
        case .shade:
            var hue: CGFloat = 0.0
            var saturation: CGFloat = 0.0
            var lightness: CGFloat = 0.0
            var alpha: CGFloat = 0.0
            color.getHue(&hue, saturation: &saturation, lightness: &lightness, alpha: &alpha)
            
            saturation -= 0.1
            lightness -= 0.14
            
            return UIColor(hue: hue, saturation: saturation, lightness: lightness, alpha: alpha)
        case .compound:
            var hue: CGFloat = 0.0
            var saturation: CGFloat = 0.0
            var lightness: CGFloat = 0.0
            var alpha: CGFloat = 0.0
            color.getHue(&hue, saturation: &saturation, lightness: &lightness, alpha: &alpha)
            
            hue += 0.047222
            saturation -= 0.45
            lightness -= 0.01
            
            
            return UIColor(hue: hue, saturation: saturation, lightness: lightness, alpha: alpha)
            
            
            
        }
    }
    
    class func getColor2(color: UIColor, mode: PIGMode) -> UIColor {
        switch mode {
            
        case .complimentary:
            var hue: CGFloat = 0.0
            var saturation: CGFloat = 0.0
            var lightness: CGFloat = 0.0
            var alpha: CGFloat = 0.0
            color.getHue(&hue, saturation: &saturation, lightness: &lightness, alpha: &alpha)
            
            lightness += 0.05
            return UIColor(hue: hue, saturation: saturation, lightness: lightness, alpha: alpha)
        case .analagous:
            var hue: CGFloat = 0.0
            var saturation: CGFloat = 0.0
            var lightness: CGFloat = 0.0
            var alpha: CGFloat = 0.0
            color.getHue(&hue, saturation: &saturation, lightness: &lightness, alpha: &alpha)
            
            hue += 0.58333333333333
            lightness += 0.15
            
            return UIColor(hue: hue, saturation: saturation, lightness: lightness, alpha: alpha)
            
        case .triade:
            return UIColor.red
        case  .shade:
            var hue: CGFloat = 0.0
            var saturation: CGFloat = 0.0
            var lightness: CGFloat = 0.0
            var alpha: CGFloat = 0.0
            color.getHue(&hue, saturation: &saturation, lightness: &lightness, alpha: &alpha)
            
            saturation -= 0.10
            lightness -= 0.06
            
            
            
            
            return UIColor(hue: hue, saturation: saturation, lightness: lightness, alpha: alpha)
            
        case .compound:
            var hue: CGFloat = 0.0
            var saturation: CGFloat = 0.0
            var lightness: CGFloat = 0.0
            var alpha: CGFloat = 0.0
            color.getHue(&hue, saturation: &saturation, lightness: &lightness, alpha: &alpha)
            
            hue += 0.047222
            saturation -= 0.69
            lightness -= 0.10
            
            return UIColor(hue: hue, saturation: saturation, lightness: lightness, alpha: alpha)
        }
    }
    
    class func getColor3(color: UIColor, mode: PIGMode) -> UIColor {
        switch mode {
            
        case .complimentary:
            var hue: CGFloat = 0.0
            var saturation: CGFloat = 0.0
            var lightness: CGFloat = 0.0
            var alpha: CGFloat = 0.0
            color.getHue(&hue, saturation: &saturation, lightness: &lightness, alpha: &alpha)
            hue += 0.5
            lightness -= 0.12
            return UIColor(hue: hue, saturation: saturation, lightness: lightness, alpha: alpha)
        case .analagous:
            var hue: CGFloat = 0.0
            var saturation: CGFloat = 0.0
            var lightness: CGFloat = 0.0
            var alpha: CGFloat = 0.0
            color.getHue(&hue, saturation: &saturation, lightness: &lightness, alpha: &alpha)
            
            hue -= 0.069444
            if hue < 0
            {
                hue += 1
            }
            saturation -= 0.20
            lightness -= 0.12
            
            return UIColor(hue: hue, saturation: saturation, lightness: lightness, alpha: alpha)
            
        case .triade:
            return UIColor.red
        case .shade:
            var hue: CGFloat = 0.0
            var saturation: CGFloat = 0.0
            var lightness: CGFloat = 0.0
            var alpha: CGFloat = 0.0
            color.getHue(&hue, saturation: &saturation, lightness: &lightness, alpha: &alpha)
            
            saturation -= 0.09
            lightness -= 0.27
            
            return UIColor(hue: hue, saturation: saturation, lightness: lightness, alpha: alpha)
            
        case .compound:
            var hue: CGFloat = 0.0
            var saturation: CGFloat = 0.0
            var lightness: CGFloat = 0.0
            var alpha: CGFloat = 0.0
            color.getHue(&hue, saturation: &saturation, lightness: &lightness, alpha: &alpha)
            
            hue += 0.3361111
            saturation += 0.05
            lightness += 0.13
            
            return UIColor(hue: hue, saturation: saturation, lightness: lightness, alpha: alpha)
        }
    }
    
    class func getColor4(color: UIColor, mode: PIGMode) -> UIColor {
        switch mode {
            
        case .complimentary:
            var hue: CGFloat = 0.0
            var saturation: CGFloat = 0.0
            var lightness: CGFloat = 0.0
            var alpha: CGFloat = 0.0
            color.getHue(&hue, saturation: &saturation, lightness: &lightness, alpha: &alpha)
            
            hue += 0.5
            return UIColor(hue: hue, saturation: saturation, lightness: lightness, alpha: alpha)
        case .analagous:
            var hue: CGFloat = 0.0
            var saturation: CGFloat = 0.0
            var lightness: CGFloat = 0.0
            var alpha: CGFloat = 0.0
            color.getHue(&hue, saturation: &saturation, lightness: &lightness, alpha: &alpha)
            
            hue -= 0.14166667
            if hue < 0
            {
                hue += 1
            }
            lightness += 0.05
            
            return UIColor(hue: hue, saturation: saturation, lightness: lightness, alpha: alpha)
            
        case .triade:
            return UIColor.red
        case .shade:
            var hue: CGFloat = 0.0
            var saturation: CGFloat = 0.0
            var lightness: CGFloat = 0.0
            var alpha: CGFloat = 0.0
            color.getHue(&hue, saturation: &saturation, lightness: &lightness, alpha: &alpha)
            
            saturation -= 0.09
            lightness -= 0.40
            
            
            return UIColor(hue: hue, saturation: saturation, lightness: lightness, alpha: alpha)
            
        case .compound:
            var hue: CGFloat = 0.0
            var saturation: CGFloat = 0.0
            var lightness: CGFloat = 0.0
            var alpha: CGFloat = 0.0
            color.getHue(&hue, saturation: &saturation, lightness: &lightness, alpha: &alpha)
            
            hue += 0.2805
            saturation -= 0.06
            lightness -= 0.15
            
            return UIColor(hue: hue, saturation: saturation, lightness: lightness, alpha: alpha)
            
            
        }
    }
}
