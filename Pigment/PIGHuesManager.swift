//
//  PIGHuesManager.swift
//  Pigment
//
//  Created by Brandon Schmuck on 2/11/17.
//  Copyright © 2017 Brandon Schmuck. All rights reserved.
//

import UIKit

class PIGHuesManager: NSObject {
    
    static let shared = PIGHuesManager()
    let accessToken = "YzJ3MU8xb29EbnYwaVdMRG82QU92eXkxOFdFNXR1Ti9aNnZ4V25HczhrUT0"
    
    class func setLightBulbs(color: UIColor, lightNum: Int) {
        let urlString = "https://www.meethue.com/api/sendmessage?token=YzJ3MU8xb29EbnYwaVdMRG82QU92eXkxOFdFNXR1Ti9aNnZ4V25HczhrUT0%3D"
        
//        let data  = ["clipmessage" : ["bridgeId": "001788fffe1a74f5", "clipCommand": [ "url": "/api/newdeveloper/lights/1/state", "method": "PUT", "body": ["hue" : 5000, "saturation" : 2000]  ] ]] as [String : Any]
//        
//        let bridgeID = "001788fffe1a74f5"
        
        var hue: CGFloat = 0.0
        var sat: CGFloat = 0.0
        var bri: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        
//        color.getHue(&hue, saturation: &sat, brightness: &bri, alpha: &alpha)
        
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
//        hue *= 65535
//        sat *= 254
//        bri *= 254
        
        red = (red > 0.04045) ? pow((red + 0.055) / (1.0 + 0.055), 2.4) : (red / 12.92);
        green = (green > 0.04045) ? pow((green + 0.055) / (1.0 + 0.055), 2.4) : (green / 12.92);
        blue = (blue > 0.04045) ? pow((blue + 0.055) / (1.0 + 0.055), 2.4) : (blue / 12.92);
        
        //Apply wide gamut conversion D65
        let X = red * 0.664511 + green * 0.154324 + blue * 0.162028;
        let Y = red * 0.283881 + green * 0.668433 + blue * 0.047685;
        let Z = red * 0.000088 + green * 0.072310 + blue * 0.986039;
        
        let fx = X / (X + Y + Z);
        let fy = Y / (X + Y + Z);
        

//        let dataString = "clipmessage=%7B+bridgeId%3A+%22001788fffe1a74f5%22%2C+clipCommand%3A+%7B+url%3A+%22%2Fapi%2Fnewdeveloper%2Flights%2F1%2Fstate%22%2C+method%3A+%22PUT%22%2C+body%3A+%7B%22hue%22%3A+\(hue)%2C+%22sat%22%3A+\(sat)%2C+%E2%80%9Cbri%E2%80%9D+%3A+\(bri)%7D++%7D+%7D&="
        
        let dataString = "clipmessage=%7B+bridgeId%3A+%22001788fffe1a74f5%22%2C+clipCommand%3A+%7B+url%3A+%22%2Fapi%2Fnewdeveloper%2Flights%2F\(lightNum)%2Fstate%22%2C+method%3A+%22PUT%22%2C+body%3A+%7B%22xy%22+%3A+%5B\(fx)%2C+\(fy)%5D%7D++%7D+%7D&="
        
        let request = PIGRequest.urlRequest(urlString: urlString, httpMethod: .POST, dataString: dataString)
        PIGRequest.urlSession(request: request) { (dict, error) in
            if(!(error != nil)) {
                print("Success!")
            }
        }
    }

}
