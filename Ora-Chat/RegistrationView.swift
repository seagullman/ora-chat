//
//  RegistrationView.swift
//  Ora-Chat
//
//  Created by Brad Siegel on 2/1/17.
//  Copyright © 2017 Brad Siegel. All rights reserved.
//

import UIKit

class RegistrationView: UIView {

    @IBOutlet fileprivate weak var nameTextField: UITextField!
    @IBOutlet fileprivate weak var emailTextField: UITextField!
    @IBOutlet fileprivate weak var passwordTextField: UITextField!
    @IBOutlet fileprivate weak var confirmPasswordTextField: UITextField!
    
    var delegate: RegistrationDelegate?
    
    @IBAction func register() {
        //TODO: need to confirm passwords match before making call
        let name = nameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        self.delegate?.register(name: name, email: email, password: password)
    }
    
}

