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
    
    func login(email: String, password: String) {
        //TODO: call service layer to log user in
        //send a closure to be called upon service call success or failure
        print("Log user in with data: \(email),\(password)")
    }
}
