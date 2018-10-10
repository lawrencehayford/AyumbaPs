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
    var url : String!
    var method : String!
    var jsonData : String!
    
    init(_ url: String, _ method: String){
            self.url = url
            self.method = method
    }
    
    func send() {
        
            Alamofire.request("https://httpbin.org/get").responseJSON { response in
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
           
        }
    }
}

