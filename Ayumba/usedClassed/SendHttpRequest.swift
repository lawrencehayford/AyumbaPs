//
//  SendHttpRequest.swift
//  Ayumba
//
//  Created by Admin on 10/10/18.
//  Copyright © 2018 Ayumba. All rights reserved.
//

import Foundation
import Alamofire

class SendHttpRequest{
    var url : String?
    var mainUrl = "http://ps.ayumba.com/api/"
    var method : String?
    var parameters :[String: String] = [:]
    var headers :[String: String] = [:]
    
    init(_ url: String, _ method: String, _ parameters: [String: String], _ headers: [String: String]  ){
            self.url = url
            self.method = method
            self.parameters = parameters
            self.headers = headers
        
    }
    
    func send(completionHandler: @escaping (String?, Error?) -> () ) {
        
        let fullurl : String = self.mainUrl+self.url!
        Alamofire.request( fullurl ,method: .post, parameters: self.parameters, headers: self.headers).validate().responseString { response in
                switch response.result {
                case .success:
                    if let json = response.result.value {
                        completionHandler(json, nil)
                    }
                case .failure(let error):
                    completionHandler(nil, error)
                }
           
           
        }
    }
  
    func parseJsonString(input : String) -> [Dictionary<String,Any>] {
        let data = input.data(using: .utf8)!
        do {
             let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>]
            return jsonArray!
        } catch {
            return []
        }
    }
    
    
}

