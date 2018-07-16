//
//  ParseManager.swift
//  BaseService
//
//  Created by Musadiq on 15/06/2018.
//  Copyright © 2018 Masroor Elahi. All rights reserved.
//

import UIKit
import Alamofire

class ParseManager: NSObject {

    class func parseResponse<T : Decodable>(data : Data? , response : T.Type)->T?{
        
        guard let dateValue = data else { return  nil }
        
        let decoder = try? JSONDecoder().decode(response, from: dateValue)
        return decoder
    }
    
    class func asDictionary<T:Codable>(param : T) -> [String: AnyObject]? {
        guard let data = try? JSONEncoder().encode(param) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: AnyObject] }
    }
    
    
}
