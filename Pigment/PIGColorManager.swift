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
            
            hue += 0.0472
            if hue > 1
            {
                hue -= 1
            }
            lightness += 0.03
            
            return UIColor(hue: hue, saturation: saturation, lightness: lightness, alpha: alpha)
            
        case .triade:
            /*var red: CGFloat = 0.0
            var green: CGFloat = 0.0
            var blue: CGFloat = 0.0*/
            var angle: CGFloat=0.0
            var magnitude: CGFloat=0.0;
            var alpha: CGFloat = 0.0
            
            var red: CGFloat = 1.0
            var green: CGFloat = 1.0
            var blue: CGFloat = 1.0
            color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            
            var rgb = Array<CGFloat>()
            for i in 0...4{
                rgb.append(0.0)
            }
            red*=34
            green*=150
            blue*=100
            
            if red>green
            {
                if blue>green
                {
                    if blue>red
                    {
                        rgb[3]=240
                        rgb[0]=blue
                        rgb[1]=red
                        rgb[2]=green
                        rgb[4]=1
                    }
                        
                    else
                    {
                        rgb[3]=0;
                        rgb[0]=red;
                        rgb[1]=blue;
                        rgb[4]=2.0;
                        rgb[2]=green;
                    }
                    
                    
                }
                else
                {
                    rgb[3]=0;
                    rgb[0]=red;
                    rgb[1]=green;
                    rgb[2]=blue;
                    rgb[4]=1;
                }
            }
            else
            {
                if blue>red
                {
                    if blue>green
                    {
                        rgb[3]=240;
                        rgb[0]=blue;
                        rgb[1]=green;
                        rgb[4]=2.0;
                        rgb[2]=red;
                    }
                    else
                    {
                        rgb[3]=120;
                        rgb[0]=green;
                        rgb[1]=blue;
                        rgb[4]=1;
                        rgb[2]=red;
                        
                    }
                    
                }
                else
                {
                    rgb[3]=120;
                    rgb[0]=green;
                    rgb[1]=red;
                    rgb[2]=blue;
                    rgb[4]=2.0;
                }
            }

        
        
        print (rgb[0] )
        print (rgb[1] )
        print (rgb[2] )

        
    
        
        
           
    
             var ratio: CGFloat=rgb[2]/(rgb[0]+rgb[1]);
    
             if(rgb[4]==2.0)
             {
                angle=rgb[3]+(120*ratio);
                rgb[1]+=(angle-rgb[3])*(255.0/60.0);
                magnitude=((255-rgb[0])+(255-rgb[1])+(255-rgb[3]))/3;
             }
             else
             {
                angle=rgb[3]+120-(120*ratio);
    
                magnitude=rgb[1]+(rgb[3]+120-angle)*(60.0/255.0);
             }
            
    /*
    public int[] getRGB(int angle,int magnitude)
    {
    int R=0;
    int G=0;
    int B=0;
    System.out.println(angle);
    magnitude+=20;
    if(angle<120)
    {
    R=255;
    if(angle>=60)
    {
    G=255-(120-angle)*255/60;
    B=0;
    G+=magnitude;
    R-=magnitude;
    }
    else
    {
    B=255-(angle-0)*255/60;
    G=0;
    G+=magnitude;
    R-=magnitude;
    }
    }
    else if(angle<240&&angle>120)
    {
    G=255;
    if(angle>=180)
    {
    R=255-(240-angle)*255/60;
    B=0;
    B+=magnitude;
    G-=magnitude;
    }
    else
    {
    B=255-(angle-120)*255/60;
    R=0;
    R+=magnitude;
    G-=magnitude;
    }
    
    }
    else if(angle<360&&angle>240)
    {
    B=255;
    if(angle<=300)
    {
    G=255-(angle-240)*255/60;
    R=0;
    R+=magnitude;
    B-=magnitude;
    }
    else
    {
    R=255-(360-angle)*255/60;
    G=0;
    G+=magnitude;
    B-=magnitude;
    }
    
    }
    
    int[] results={R,G,B};
    return results;
    */
    
                    
        
        
            
            
            return UIColor(colorLiteralRed: Float(red), green: Float(green), blue: Float(blue), alpha: Float(alpha))
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
            
            hue += 0.09
            if hue > 1
            {
                hue -= 1
            }
            saturation -= 0.10
            lightness -= 0.38
            
            
            return UIColor(hue: hue, saturation: saturation, lightness: lightness, alpha: alpha)
            
        case .triade:
            var red: CGFloat = 0.0
            var green: CGFloat = 0.0
            var blue: CGFloat = 0.0
            var alpha: CGFloat = 0.0
            
            color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            return UIColor(colorLiteralRed: Float(red), green: Float(green), blue: Float(blue), alpha: Float(alpha))
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
                hue -= 1
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
            
            hue += 0.916667
            if hue < 1
            {
                hue -= 1
            }
            saturation -= 0.10
            lightness -= 0.02
            
            return UIColor(hue: hue, saturation: saturation, lightness: lightness, alpha: alpha)
            
        case .triade:
            var red: CGFloat = 0.0
            var green: CGFloat = 0.0
            var blue: CGFloat = 0.0
            var alpha: CGFloat = 0.0
            
            color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            return UIColor(colorLiteralRed: Float(red), green: Float(green), blue: Float(blue), alpha: Float(alpha))
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
            if hue > 1
            {
                hue -= 1
            }
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
            
            hue += 0.8333
            if hue > 1
            {
                hue -= 1
            }
            lightness += 0.03
            
            return UIColor(hue: hue, saturation: saturation, lightness: lightness, alpha: alpha)
            
        case .triade:
            var red: CGFloat = 0.0
            var green: CGFloat = 0.0
            var blue: CGFloat = 0.0
            var alpha: CGFloat = 0.0
            
            color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            
            
            
            
            return UIColor(colorLiteralRed: Float(red), green: Float(green), blue: Float(blue), alpha: Float(alpha))
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
            if hue > 1
            {
                hue -= 1
            }
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
