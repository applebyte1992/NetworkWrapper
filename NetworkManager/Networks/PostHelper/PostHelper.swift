//
//  PostHelper.swift
//  NetworkManager
//
//  Created by Masroor Elahi on 7/14/18.
//  Copyright © 2018 Masroor Elahi. All rights reserved.
//

import UIKit
import Alamofire

class PostHelper: NSObject {

    var baseURL             : String            = ""
    var requestHeaders      : [String:String]?  = [:]
    var authorizationToken  : String            = ""
    private var manager     : SessionManager
    typealias completionBlock       = ((Data?, Error?) -> Void)
    
    override init() {
        let configuration                           = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest     = 30
        manager                                     = Alamofire.SessionManager(configuration: configuration)
    }
    
    
    required convenience init(baseURL : String , requestHeaders : [String:String]?) {
        self.init()
        self.baseURL        = baseURL
        self.requestHeaders = requestHeaders
    }
    
    func updateAuthorizationToken(token : String) {
        self.authorizationToken = token
    }
    
    //MARK:- Alamofire Get/POST
    
    func POST(action : String , paramters : [String:AnyObject] , encoding : ParameterEncoding = JSONEncoding.default , completionBlock : @escaping completionBlock) {
        
        
        self.printRequest(action: action, params: paramters)
        self.executeRequest(method: .post, action: action, params: paramters, encoding: encoding, apiHeader: self.requestHeaders!, completionBlock: completionBlock)
        
    }
    
    func GET(action : String , paramters : [String:AnyObject]?, completionBlock : @escaping completionBlock) {
        
        self.printRequest(action: action, params: paramters)
        self.executeRequest(method: .get, action: action, params: paramters, encoding: JSONEncoding.default, apiHeader: self.requestHeaders!, completionBlock: completionBlock)
    }
    
    func executeRequest(method : HTTPMethod , action : String , params : [String:AnyObject]?,encoding : ParameterEncoding,apiHeader : [String:String], completionBlock : @escaping completionBlock) {
        
        self.updateHeaderToken(header: apiHeader)
        
        let url = self.baseURL + action
        manager.request(url,method: method, parameters: params, encoding: encoding, headers: apiHeader).validate().responseJSON { (response) in
            guard response.result.isSuccess else  {
                completionBlock(nil,response.result.error)
                return
            }
            guard let responseData = response.data else {
                completionBlock(nil , self.getParsingError())
                return
            }
            self.printJSON(data: responseData)
            completionBlock(responseData, nil)
        }
    }
    
    func updateHeaderToken(header : [String:String]){
        var headers = header
        if self.authorizationToken != "" {
            headers["Authorization"] = "Bearer " + self.authorizationToken
        }
    }
    
}
