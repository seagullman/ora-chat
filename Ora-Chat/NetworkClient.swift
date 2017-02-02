//
//  NetworkClient.swift
//  Ora-Chat
//
//  Created by Brad Siegel on 2/1/17.
//  Copyright © 2017 Brad Siegel. All rights reserved.
//

import Alamofire
import SwiftKeychainWrapper

protocol NetworkInterface {
    func registerUser(name: String, email: String, password: String, completion: @escaping (DataResponse<Any>?) -> Void)
    func login(email: String, password: String, completion: @escaping (DataResponse<Any>?) -> Void)
    func logout(completion: @escaping (DataResponse<Any>?) -> Void)
}

class NetworkClient: NetworkInterface {
    
    fileprivate let registerUrl = "https://private-93240c-oracodechallenge.apiary-mock.com/users"
    fileprivate let loginUrl = "https://private-93240c-oracodechallenge.apiary-mock.com/auth/login"
    fileprivate let logoutUrl = "https://private-93240c-oracodechallenge.apiary-mock.com/auth/logout"
    
    fileprivate let authTokenKey = "auth-token"

    func registerUser(name: String,
                      email: String,
                      password: String,
                      completion: @escaping (DataResponse<Any>?) -> Void) {
        
        let params = [
            "name": name,
            "email": email,
            "password": password,
            "password_confirmation": password
        ]
        
        self.post(url: self.registerUrl,
                  params: params,
                  completion: { (response) in
            completion(response)
        }, headers: nil)
    }
    
    func login(email: String,
               password: String,
               completion: @escaping (DataResponse<Any>?) -> Void) {
        
        let params = [
            "email": email,
            "password": password,
        ]
        
        self.post(url: self.loginUrl,
                  params: params,
                  completion: { (response) in
            //Store auth token in Keychain 
            let token = response?.response?.allHeaderFields["Authorization"] as? String ?? "" //TODO: fix this
            _ = KeychainWrapper.standard.set(token, forKey: self.authTokenKey)
                    
            completion(response)
        }, headers: nil)
    }
    
    func logout(completion: @escaping (DataResponse<Any>?) -> Void) {
        //TODO: GET to /logout
        let authToken: String = KeychainWrapper.standard.string(forKey: authTokenKey) ?? ""
        
        let headers = [
            "Content-Type": "application/json; charset=UTF-8",
            "Authorization": authToken
        ]
        
        self.get(url: logoutUrl,
                 completion: { (response) in
                    if response?.result.isSuccess == true {
                        //logout successful, invalidate auth token
                        _ = KeychainWrapper.standard.removeObject(forKey: self.authTokenKey)
                    }
            completion(response)
        }, headers: headers)
    }
    
    //MARK: Private functions
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
    
    private func get(url: String,
                      completion: @escaping (DataResponse<Any>?) -> Void,
                      headers: [String: String]?) {
        
        Alamofire.request(url,
                          method: .get,
                          encoding: JSONEncoding.default,
                          headers: headers)
            .responseJSON { response in
                
                completion(response)
        }
    }

}
