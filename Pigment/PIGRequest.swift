//
//  PIGRequest.swift
//  Pigment
//
//  Created by Brandon Schmuck on 2/11/17.
//  Copyright © 2017 Brandon Schmuck. All rights reserved.
//

import UIKit

//
//  BDRequest.swift
//  Building Depot Mobile
//
//  Created by Brandon Schmuck on 12/22/16.
//  Copyright © 2016 Brandon Schmuck. All rights reserved.
//

import UIKit

enum urlMethod {
    case GET
    case POST
    case PUT
}

class PIGRequest: NSObject {
    
    
    //Method to create a new URL request
    class func urlRequest(urlString: String, httpMethod: urlMethod, dataString: String) -> NSMutableURLRequest {
        
        let url = NSURL(string: urlString)!
        let request = NSMutableURLRequest(url: url as URL)
        
//        if let body = data {
//            do {
////                let body = try JSONSerialization.data(withJSONObject: body as NSDictionary, options: JSONSerialization.WritingOptions.prettyPrinted)
//                
//                request.setValue("\(body.count)", forHTTPHeaderField: "Content-Length")
//                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//                request.setValue("application/json", forHTTPHeaderField: "Accept")
//            } catch {
//                
//            }
//        }
        

        
        var postData = dataString.data(using: String.Encoding.ascii, allowLossyConversion: true)
        let postLength = "\(postData?.count)"
        request.setValue(postLength, forHTTPHeaderField: "Content-Length")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = postData
        
        
        switch httpMethod.self {
        case .GET:
            request.httpMethod = "GET"
            break
        case .POST:
            request.httpMethod = "POST"
            break
        case .PUT:
            request.httpMethod = "PUT"
            break
        }
        
        
        return request
    }
    
    //Method to start a URL session with a request
    class func urlSession(request: NSMutableURLRequest, callback: @escaping (NSDictionary?, Error?) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            var dataDict: NSDictionary?
            if let data = data {
                let dataString = String(data: data, encoding: String.Encoding.utf8)
                print("DataString: " + dataString!)
                do {
                    dataDict = try JSONSerialization.jsonObject(with: data, options:.mutableLeaves) as? NSDictionary
                    callback(dataDict, error)
                }
                catch {
                }
            } else {
                callback(nil, error)
            }
        }
        task.resume()
    }
    
}
