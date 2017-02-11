//
//  PIGColorManager.swift
//  Pigment
//
//  Created by Brandon Schmuck on 2/10/17.
//  Copyright © 2017 Brandon Schmuck. All rights reserved.
//

import UIKit


enum PIGMode {
    case complimentary
    case triade
    case analagous
}

class PIGColorManager: NSObject {
    
    //Returns a complementary color of the given color
    class func getColor1(color: UIColor, mode: PIGMode) -> UIColor {
        switch mode {
            
        case .complimentary:
            return UIColor.red
        case .analagous:
            return UIColor.red
        case .triade:
            return UIColor.red
            
        }
    }
    
    class func getColor2(color: UIColor, mode: PIGMode) -> UIColor {
        switch mode {
            
        case .complimentary:
            return UIColor.red
        case .analagous:
            return UIColor.red
        case .triade:
            return UIColor.red
            
        }
    }
    
    class func getColor3(color: UIColor, mode: PIGMode) -> UIColor {
        switch mode {
            
        case .complimentary:
            return UIColor.red
        case .analagous:
            return UIColor.red
        case .triade:
            return UIColor.red
            
        }
    }
    
    class func getColor4(color: UIColor, mode: PIGMode) -> UIColor {
        switch mode {
            
        case .complimentary:
            return UIColor.red
        case .analagous:
            return UIColor.red
        case .triade:
            return UIColor.red
            
        }
    }
}
