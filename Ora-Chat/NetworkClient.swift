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
    func login(email: String, password: String, completion: @escaping (ResponseError?) -> Void)
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

                var responseError: ResponseError? = nil
                let responseCode = response.response?.statusCode
                print(responseCode as Any)
                
                if responseCode != 201 {
                    responseError = ResponseError.failure(description: "Unable to register user")
                }
                
                completion(responseError)
        }
    }
    
    func login(email: String, password: String, completion: @escaping (ResponseError?) -> Void) {
        //let token = response.response?.allHeaderFields["Authorization"]
    }
}
