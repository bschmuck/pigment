//
//  PIGBroadcastManager.swift
//  Pigment
//
//  Created by Brandon Schmuck on 2/11/17.
//  Copyright © 2017 Brandon Schmuck. All rights reserved.
//

import UIKit

class PIGBroadcastManager: NSObject {
    
    class func broadcastColor(color: UIColor, channel: Int, name: String) {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        var urlString = "http://steelhacks.herokuapp.com/colors/\(channel)?red=\(Int(red * 255))&green=\(Int(green * 255))&blue=\(Int(blue * 255))&name=test"
        
        let request = PIGRequest.urlRequest(urlString: urlString, httpMethod: .POST, dataString: nil, dict: nil)
        PIGRequest.urlSession(request: request) { (dict, error) in
            if(!(error != nil)) {
                print("Success!")
            }
        }
    }

}
