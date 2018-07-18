//
//  NetworkUtils.swift
//  NetworkManager
//
//  Created by Masroor Elahi on 7/14/18.
//  Copyright © 2018 Masroor Elahi. All rights reserved.
//

import UIKit

extension NetworkHelper {
    func getInvalidParamsError()->Error{
        
        let parsingError = "Invalid paramters."
        let error = NSError.init(domain: "com.dinifi.BaseService", code: 9002, userInfo: [NSLocalizedDescriptionKey : parsingError])
        return error
    }
    func getUnknowError()->Error{
        
        let parsingError = "Unknow error"
        let error = NSError.init(domain: "com.teo.BaseService", code: 9003, userInfo: [NSLocalizedDescriptionKey : parsingError])
        return error
    }
}
