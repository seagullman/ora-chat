//
//  LoginView.swift
//  Ora-Chat
//
//  Created by Brad Siegel on 2/1/17.
//  Copyright © 2017 Brad Siegel. All rights reserved.
//

import UIKit

class LoginView: UIView {

    @IBOutlet fileprivate weak var emailTextField: UITextField!
    @IBOutlet fileprivate weak var passwordTextField: UITextField!
    
    var delegate: LoginDelegate?
    
    @IBAction func login() {
        let email = self.emailTextField.text ?? ""
        let password = self.passwordTextField.text ?? ""
        
        self.delegate?.login(email: email, password: password)
    }
    
    func resetTextFields() {
        self.passwordTextField.text = ""
        self.endEditing(true)
    }
}
