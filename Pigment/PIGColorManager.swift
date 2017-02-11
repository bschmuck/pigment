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
}

class PIGColorManager: NSObject {
    
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
            
            
            return UIColor.red
        case .analagous:
            return UIColor.red
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
            
            return UIColor.red
            
            
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
            return UIColor.red
        case .analagous:
            return UIColor.red
        case .triade:
            return UIColor.red
        case  .shade:
            return UIColor.red
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
            return UIColor.red
        case .analagous:
            return UIColor.red
        case .triade:
            return UIColor.red
        case .shade:
            return UIColor.red
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
            
            hue += 0.05
            return UIColor.red
        case .analagous:
            return UIColor.red
        case .triade:
            return UIColor.red
        case .shade:
            return UIColor.red
            
        }
    }
}
