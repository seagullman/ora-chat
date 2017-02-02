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
    @IBOutlet fileprivate weak var registerButton: UIButton!
    
    var delegate: RegistrationDelegate?
    
    @IBAction func register() {
        //TODO: need to confirm passwords match before making call
        self.registerButton.isEnabled = false
        let name = nameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        self.delegate?.register(name: name, email: email, password: password)
    }
    
    /**
    *   This will be be called to re-enable the register button 
        if the register service call fails
    */
    func enableRegisterButton() {
        self.registerButton.isEnabled = true
    }
    
}

