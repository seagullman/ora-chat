//
//  NetworkClient.swift
//  Ora-Chat
//
//  Created by Brad Siegel on 2/1/17.
//  Copyright © 2017 Brad Siegel. All rights reserved.
//

import Alamofire

protocol NetworkInterface {
    func registerUser(name: String, email: String, password: String, completion: @escaping (DataResponse<Any>?) -> Void)
    func login(email: String, password: String, completion: @escaping (DataResponse<Any>?) -> Void)
}

class NetworkClient: NetworkInterface {

    //TODO: refactor to generic POST function
    func registerUser(name: String,
                      email: String,
                      password: String,
                      completion: @escaping (DataResponse<Any>?) -> Void) {
        
        let url = "https://private-93240c-oracodechallenge.apiary-mock.com/users"
        
        let params = [
            "name": name,
            "email": email,
            "password": password,
            "password_confirmation": password
        ]
        
        self.post(url: url, params: params, completion: { (response) in
            completion(response)
        }, headers: nil)
    }
    
    func login(email: String,
               password: String,
               completion: @escaping (DataResponse<Any>?) -> Void) {
        
        let url = "https://private-93240c-oracodechallenge.apiary-mock.com/auth/login"
        
        let params = [
            "email": email,
            "password": password,
        ]
        
        self.post(url: url, params: params, completion: { (response) in
            //TODO: add authorization token to keychain here
            //let token = response.response?.allHeaderFields["Authorization"]
            completion(response)
        }, headers: nil)
    }
    
    private func post(url: String,
                      params: [String: String],
                      completion: @escaping (DataResponse<Any>?) -> Void,
                      headers: [String: String]?) {
        
        Alamofire.request(url,
                          method: .post,
                          parameters: params,
                          encoding: JSONEncoding.default,
                          headers: headers)
            .responseJSON { response in
                
            completion(response)
        }
    }
}
