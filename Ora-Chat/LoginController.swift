//
//  LoginController.swift
//  Ora-Chat
//
//  Created by Brad Siegel on 2/1/17.
//  Copyright © 2017 Brad Siegel. All rights reserved.
//

import UIKit

protocol LoginDelegate {
    func login(email: String, password: String)
}

class LoginController: UIViewController,
                       LoginDelegate {

    @IBOutlet fileprivate var loginView: LoginView! {
        didSet {
            self.loginView.delegate = self
        }
    }
    
    let networkClient = NetworkClient()
    
    func login(email: String, password: String) {
        self.networkClient.login(email: email, password: password) { (response) in
            if response?.result.isSuccess == true {
                //TODO: segue to landing screen
            }
        }
    }
}
