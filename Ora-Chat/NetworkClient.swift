//
//  NetworkClient.swift
//  Ora-Chat
//
//  Created by Brad Siegel on 2/1/17.
//  Copyright © 2017 Brad Siegel. All rights reserved.
//

import Alamofire

enum ResponseError: Error {
    case failure(description: String)
}

protocol NetworkInterface {
    func registerUser(name: String, email: String, password: String, completion: @escaping (ResponseError?) -> Void)
}

class NetworkClient: NetworkInterface {

    //TODO: refactor to generic POST function
    func registerUser(name: String,
                      email: String,
                      password: String,
                      completion: @escaping (ResponseError?) -> Void) {
        
        let params = [
            "name": name,
            "email": email,
            "password": password,
            "password_confirmation": password
        ]

        let url = "https://private-93240c-oracodechallenge.apiary-mock.com/users"
        Alamofire.request(url,
                          method: .post,
                          parameters: params,
                          encoding: JSONEncoding.default,
                          headers: nil)
            .responseJSON { response in
                let token = response.response?.allHeaderFields["Authorization"]
                var responseError: ResponseError? = nil
                
                if token == nil {
                    responseError = ResponseError.failure(description: "Authorization token is nil.")
                } 
                
                completion(responseError)
                print(response.response?.allHeaderFields["Authorization"] as Any)   // result of response serialization
        }
    }
}
