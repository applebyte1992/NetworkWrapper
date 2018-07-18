//
//  DinifiServiceHelpers.swift
//  BaseService
//
//  Created by Musadiq on 15/06/2018.
//  Copyright © 2018 Masroor Elahi. All rights reserved.
//

import Foundation
// MARK:- Logs
extension PostHelper {
    
    func printJSON(data : Data?){
        if data != nil && NetworkHelper.enableLogs {
            print(String.init(data: data!, encoding: .utf8) ?? "")
        }
    }
    
    func printRequest(action : String , params : [String:AnyObject]?){
        if NetworkHelper.enableLogs {
            print("URL :" + action)
            if let param = params {
                print("Params : " + param.description)
            }
            
        }
    }
    
}

// MARK:- Error Handling
extension PostHelper {
    func getParsingError()->Error{
        
        let parsingError = "Sorry for inconvience. Response from server is not valid."
        let error = NSError.init(domain: "com.teo.NetworkManager", code: 9001, userInfo: [NSLocalizedDescriptionKey : parsingError])
        return error
    }
    
    func getError(data : Data?)->AnyObject? {
        
        if let responseData = data {
            do {
                let json = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [String:AnyObject]
                return json as AnyObject
            } catch {
                print("Invalid JSON")
            }
        }
        return nil
    }
}





