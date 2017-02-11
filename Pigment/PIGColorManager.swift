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
            
            hue += 0.03333
            lightness += 0.03
            
            return UIColor(hue: hue, saturation: saturation, lightness: lightness, alpha: alpha)
            
        case .triade:
            var red: CGFloat = 0.0
            var green: CGFloat = 0.0
            var blue: CGFloat = 0.0
            var alpha: CGFloat = 0.0
            
            
            color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            red*=255
            green*=255
            blue*=255
            
            var color2=Array<CGFloat>()
            color2.append(blue)
            color2.append(red)
            color2.append(green)
        
            
           
            
            
            return UIColor(colorLiteralRed: Float(color2[0]), green: Float(color2[1]), blue: Float(color2[2]), alpha: Float(alpha))
            
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
            if hue > 1
            {
                hue -= 1
            }
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
            
            hue += 0.01666667
            saturation -= 0.10
            lightness -= 0.38
            
            return UIColor(hue: hue, saturation: saturation, lightness: lightness, alpha: alpha)
            
        case .triade:
            var red: CGFloat = 0.0
            var green: CGFloat = 0.0
            var blue: CGFloat = 0.0
            var alpha: CGFloat = 0.0
            
            color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            
            var color2=Array<CGFloat>()
            color2.append(blue)
            color2.append(red)
            color2.append(green)
            
            return UIColor(colorLiteralRed: Float(color2[0]), green: Float(color2[1]), blue: Float(color2[2]), alpha: Float(alpha))
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
            if hue > 1
            {
                
            }
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
            if hue > 1
            {
                hue -= 1
            }
            lightness -= 0.12
            return UIColor(hue: hue, saturation: saturation, lightness: lightness, alpha: alpha)
        case .analagous:
           
            var hue: CGFloat = 0.0
            var saturation: CGFloat = 0.0
            var lightness: CGFloat = 0.0
            var alpha: CGFloat = 0.0
            color.getHue(&hue, saturation: &saturation, lightness: &lightness, alpha: &alpha)
            
            hue -= 0.0222222
            saturation -= 0.10
            lightness -= 0.02
            
            return UIColor(hue: hue, saturation: saturation, lightness: lightness, alpha: alpha)
            
        case .triade:
            var red: CGFloat = 0.0
            var green: CGFloat = 0.0
            var blue: CGFloat = 0.0
            var alpha: CGFloat = 0.0
            
            color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            var color4=Array<CGFloat>()
            color4.append(green)
            color4.append(blue)
            color4.append(red)
            
            return UIColor(colorLiteralRed: Float(color4[0]), green: Float(color4[1]), blue: Float(color4[2]), alpha: Float(alpha))
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
            if hue > 1
            {
                hue -= 1
            }
            return UIColor(hue: hue, saturation: saturation, lightness: lightness, alpha: alpha)
        case .analagous:
            
            var hue: CGFloat = 0.0
            var saturation: CGFloat = 0.0
            var lightness: CGFloat = 0.0
            var alpha: CGFloat = 0.0
            color.getHue(&hue, saturation: &saturation, lightness: &lightness, alpha: &alpha)
            
         
            
            hue += 0.03333
            lightness += 0.03
            
            return UIColor(hue: hue, saturation: saturation, lightness: lightness, alpha: alpha)
            
        case .triade:
            var red: CGFloat = 0.0
            var green: CGFloat = 0.0
            var blue: CGFloat = 0.0
            var alpha: CGFloat = 0.0
            
            
            color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            
            
                var color5=Array<CGFloat>()
            
                color5.append(green)
                color5.append(blue)
                color5.append(red)
            

            
            return UIColor(colorLiteralRed: Float(color5[0]), green: Float(color5[1]), blue: Float(color5[2]), alpha: Float(alpha))
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
    
    class func imageWithColors(colors: [UIColor]) -> UIImage {
        
        let rect = CGRect(origin: CGPoint(x: 0, y:0), size: CGSize(width: 500, height: 500))
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()!
        var rects = Array<CGRect>()

        for i in 0..<5 {
            let rect = CGRect(origin: CGPoint(x: 0, y:100*i), size: CGSize(width: 500, height: 100))
            context.setFillColor(colors[i].cgColor)
            context.fill(rect)
            rects.append(rect)
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
