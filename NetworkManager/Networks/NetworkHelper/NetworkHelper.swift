//
//  NetworkHelper.swift
//  NetworkManager
//
//  Created by Masroor Elahi on 7/14/18.
//  Copyright © 2018 Masroor Elahi. All rights reserved.
//

import UIKit
import Alamofire

public class NetworkHelper: NSObject {
    
    private var postHelper      : PostHelper!
    static var enableLogs       : Bool = true
    
    public typealias failureBlock       = ((Error?,AnyObject?) -> Void)
    public typealias finishedBlock      = ((Bool) -> Void)
    
    required public init(baseURL : String , requestHeader :[String:String]?) {
        postHelper = PostHelper(baseURL: baseURL, requestHeaders: requestHeader)
    }
    
    public func updateAuthorizationToken(token : String) {
        self.postHelper.updateAuthorizationToken(token: token)
    }
    
    public func setBaseURL(url : String) {
        self.postHelper.setBaseURL(url: url)
    }
    
    /// Set Paramters and response loging enabled / Disabled. Default is enable
    ///
    /// - Parameter enable: True of False
    public func setLogging(enable : Bool){
        NetworkHelper.enableLogs = enable
    }
    
    /// Sends Post Request
    ///
    /// - Parameters:
    ///   - action: Endpoint for API /example/id
    ///   - paramters: paramters for request - Must implement codeable
    ///   - encoding: Passed any encoding if needed default is JSONEncoding.default
    ///   - completionBlock: Get reponse in type which you expect or gets error
    public func sendPOST<T:Codable,U:Codable>(action : String , paramters : T , encoding : ParameterEncoding = JSONEncoding.default , successBlock : @escaping (U) -> () , failure : @escaping failureBlock, finished : @escaping finishedBlock) {
        
        guard let params = ParseManager.asDictionary(param: paramters) else {
            self.handleInvalidParams(failure: failure, finished: finished)
            return
        }
        
        self.postHelper.POST(action: action, paramters: params , encoding: encoding) { (data, error, any) in
            self.handleAPIResponse(data: data, error: error, errorData: any, successBlock: successBlock, failure: failure, finished: finished)
        }
    }
    /// Sends Get Request
    ///
    /// - Parameters:
    ///   - action: Endpoint for API /example/id
    ///   - paramters: paramters for request - Must implement codeable
    ///   - encoding: Passed any encoding if needed default is JSONEncoding.default
    ///   - completionBlock: Get reponse in type which you expect or gets error
    public func sendGET<T:Codable , U:Codable>(action : String , paramters : T , encoding : ParameterEncoding = JSONEncoding.default , successBlock : @escaping (U) -> () , failure : @escaping failureBlock, finished : @escaping finishedBlock) {
        
        guard let params = ParseManager.asDictionary(param: paramters) else {
            self.handleInvalidParams(failure: failure, finished: finished)
            return
        }
        self.postHelper.GET(action: action, paramters: params) { (data, error, any) in
           self.handleAPIResponse(data: data, error: error, errorData: any, successBlock: successBlock, failure: failure, finished: finished)
        }
    }
    
    
    private func handleInvalidParams(failure : @escaping failureBlock , finished : @escaping finishedBlock) {
        failure(getInvalidParamsError(),nil)
        finished(false)
    }
    
    private func handleAPIResponse<U:Codable>(data : Data? , error : Error? , errorData : AnyObject?, successBlock : @escaping (U) -> () , failure : @escaping failureBlock, finished : @escaping finishedBlock) {
        
        if let parsedResponse = ParseManager.parseResponse(data: data, response: U.self) {
            successBlock(parsedResponse)
            finished(true)
        }
        else if let err = error {
            failure(err,errorData)
            finished(false)
        }
        else{
            failure(self.getUnknowError(),errorData)
            finished(false)
        }
    }
    
}
