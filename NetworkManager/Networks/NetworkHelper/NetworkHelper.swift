//
//  NetworkHelper.swift
//  NetworkManager
//
//  Created by Masroor Elahi on 7/14/18.
//  Copyright © 2018 Masroor Elahi. All rights reserved.
//

import UIKit
import Alamofire

class NetworkHelper: NSObject {
    
    private var postHelper      : PostHelper!
    static var enableLogs       : Bool = true
    
    required init(baseURL : String , requestHeader :[String:String]?) {
        postHelper = PostHelper(baseURL: baseURL, requestHeaders: requestHeader)
    }
    
    func updateAuthorizationToken(token : String) {
        self.postHelper.updateAuthorizationToken(token: token)
    }
    
    /// Set Paramters and response loging enabled / Disabled. Default is enable
    ///
    /// - Parameter enable: True of False
    public func setLogging(enable : Bool){
        NetworkHelper.enableLogs = enable
    }
    
    public func sendPOST<T:Codable>(action : String , paramters : T , encoding : ParameterEncoding = JSONEncoding.default , completionBlock : @escaping (T? , Error?) -> ()) {
        
        guard let params = ParseManager.asDictionary(param: paramters) else {
            completionBlock(nil , getInvalidParamsError())
            return
        }
        
        self.postHelper.POST(action: "", paramters: params) { (data, error) in
            completionBlock(ParseManager.parseResponse(data: data, response: T.self) , error)
        }
    }
    
    public func sendGET<T:Codable>(action : String , paramters : T? , encoding : ParameterEncoding = JSONEncoding.default , completionBlock : @escaping (T? , Error?) -> ()) {
        
        guard let params = ParseManager.asDictionary(param: paramters) else {
            completionBlock(nil , getInvalidParamsError())
            return
        }
        
        self.postHelper.GET(action: "", paramters: params) { (data, error) in
            completionBlock(ParseManager.parseResponse(data: data, response: T.self) , error)
        }
    }
    
}
