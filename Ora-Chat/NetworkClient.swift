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
    func currentUser(completion: @escaping (User) -> Void)
    func updateUser(name: String, email: String, password: String, completion: @escaping (DataResponse<Any>?) -> Void)
    func getChats(completion: @escaping ([Chat]) -> Void)
}

class NetworkClient: NetworkInterface {
    
    private let registerUrl = "https://private-93240c-oracodechallenge.apiary-mock.com/users"
    private let loginUrl = "https://private-93240c-oracodechallenge.apiary-mock.com/auth/login"
    private let logoutUrl = "https://private-93240c-oracodechallenge.apiary-mock.com/auth/logout"
    private let currentUserUrl = "https://private-93240c-oracodechallenge.apiary-mock.com/users/current"
    private let chatsUrl = "https://private-93240c-oracodechallenge.apiary-mock.com/chats?page=1&limit=50"
    
    private let authTokenKey = "auth-token"
    private let content_type = "application/json; charset=UTF-8"

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
        }, header: nil)
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
            let token = response?.response?.allHeaderFields["Authorization"] as? String ?? ""
            _ = KeychainWrapper.standard.set(token, forKey: self.authTokenKey)
                    
            completion(response)
        }, header: nil)
    }
    
    func logout(completion: @escaping (DataResponse<Any>?) -> Void) {

        self.get(url: logoutUrl,
                 completion: { (response) in
                    if response?.result.isSuccess == true {
                        //logout successful, invalidate auth token
                        _ = KeychainWrapper.standard.removeObject(forKey: self.authTokenKey)
                    }
            completion(response)
        }, header: self.authHeader())
    }
    
    func currentUser(completion: @escaping (User) -> Void) {
        
        self.get(url: currentUserUrl, completion: { (response) in
            print(response?.result.value as Any)
            let responseDictionary = response?.result.value as! [String: AnyObject] //fix force unwrap
            let user = User(dict: responseDictionary["data"] as! [String : AnyObject]) //fix force unwrap
            completion(user)
        }, header: self.authHeader())
        
    }
    
    func updateUser(name: String, email: String, password: String, completion: @escaping (DataResponse<Any>?) -> Void) {
        
        let params = [
            "name": name,
            "email": email,
            "password": password,
            "password_confirmation": password
        ]
        
        self.patch(url: self.currentUserUrl, params: params, completion: { (response) in
            completion(response)
        }, header: self.authHeader())
    }
    
    func getChats(completion: @escaping ([Chat]) -> Void) {
        self.get(url: chatsUrl,
                 completion: { (response) in
                    guard let data = response?.data else { return }
                    
                    let json = try? JSONSerialization.jsonObject(with: data, options: [])
                    
                    guard let rootJson = json as? [String: Any] else { return }
                    
                    let chats = rootJson["data"] as? [AnyObject]
                    var allChats: [Chat] = []
                    
                    chats?.forEach({ (chat) in
                        allChats.append(Chat(dict: chat as! [String : AnyObject]))
                    })
                    completion(allChats)

        }, header: self.authHeader())
    }
    
    //MARK: Private functions
    private func post(url: String,
                      params: [String: Any],
                      completion: @escaping (DataResponse<Any>?) -> Void,
                      header: [String: String]?) {
        
        Alamofire.request(url,
                          method: .post,
                          parameters: params,
                          encoding: JSONEncoding.default,
                          headers: header)
            .responseJSON { response in
                
            completion(response)
        }
    }
    
    private func get(url: String,
                     params: [String: Any]? = nil,
                      completion: @escaping (DataResponse<Any>?) -> Void,
                      header: [String: String]?) {
        
        Alamofire.request(url,
                          method: .get,
                          parameters: params,
                          encoding: JSONEncoding.default,
                          headers: header)
            .responseJSON { response in
                completion(response)
        }
    }
    
    private func patch(url: String,
                      params: [String: Any],
                      completion: @escaping (DataResponse<Any>?) -> Void,
                      header: [String: String]?) {
        
        Alamofire.request(url,
                          method: .patch,
                          parameters: params,
                          encoding: JSONEncoding.default,
                          headers: header)
            .responseJSON { response in
                
                completion(response)
        }
    }
    
    private func authHeader() -> [String: String] {
        let authToken: String = KeychainWrapper.standard.string(forKey: authTokenKey) ?? ""
        
        let header = [
            "Content-Type": content_type,
            "Authorization": authToken
        ]
        return header
    }
    
    /*
     * Use for testing
     */
    func sampleChatsData() -> NSDictionary? {
        if let path = Bundle.main.path(forResource: "chats_sample_data", ofType: "json") {
            do {
                let jsonData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
                do {
                    let jsonResult: NSDictionary = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    return jsonResult
                    
                } catch {}
            } catch {}
        }
        return nil
    }
        
}
