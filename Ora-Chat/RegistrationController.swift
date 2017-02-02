//
//  RegistrationController.swift
//  Ora-Chat
//
//  Created by Brad Siegel on 2/1/17.
//  Copyright © 2017 Brad Siegel. All rights reserved.
//

import UIKit

protocol RegistrationDelegate: class {
    func register(name: String, email: String, password: String)
}

class RegistrationController: UIViewController,
                              RegistrationDelegate {
    
    @IBOutlet fileprivate var registrationView: RegistrationView! {
        didSet {
            self.registrationView.delegate = self
        }
    }
    
    let networkClient = NetworkClient()
    
    func register(name: String, email: String, password: String) {
        //TODO: call service layer to register user
        //pass a closure to be called upon success or failure of user creation
        //upon successful creation, call /login (with token?)
        networkClient.registerUser(name: name, email: email, password: password) { (error) in
            if error == nil {
                print("Registration successful. Attempting to login")
                self.networkClient.login(email: email, password: password, completion: { (error) in
                    //TODO: segue to landing screen
                })
            }
        }
    }
}
