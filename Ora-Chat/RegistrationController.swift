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
        networkClient.registerUser(name: name, email: email, password: password) { (response) in
            if response?.result.isSuccess == true {
                print("Registration successful. Attempting to login")
                self.networkClient.login(email: email, password: password, completion: { (response) in
                    //TODO: segue to landing screen
                    print("LOGGING IN")
                    print(response as Any)
                    self.navigationController?.performSegue(withIdentifier: "landingSegue",
                                                            sender: self)
                })
            } else {
                //result is failure, re-enable register button
                self.registrationView.enableRegisterButton()
            }
        }
    }
}
