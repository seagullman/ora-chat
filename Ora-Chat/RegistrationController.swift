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
    
    func register(name: String, email: String, password: String) {
        //TODO: call service layer to register user
        //pass a closure to be called upon success or failure of user creation
    }
}
