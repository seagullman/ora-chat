//
//  RegistrationView.swift
//  Ora-Chat
//
//  Created by Brad Siegel on 2/1/17.
//  Copyright © 2017 Brad Siegel. All rights reserved.
//

import UIKit

class RegistrationView: UIView,
                        PasswordFieldValidatorDelegate {

    @IBOutlet fileprivate weak var nameTextField: UITextField!
    @IBOutlet fileprivate weak var emailTextField: UITextField!
    @IBOutlet fileprivate weak var passwordTextField: UITextField!
    @IBOutlet fileprivate weak var confirmPasswordTextField: UITextField!
    @IBOutlet fileprivate weak var registerButton: UIButton!
    
    var delegate: RegistrationDelegate?
    var textFieldDelegate: PasswordFieldValidator?
    
    override func awakeFromNib() {
        self.textFieldDelegate = PasswordFieldValidator(passwordField: self.passwordTextField,
                                               confirmationTextField: self.confirmPasswordTextField,
                                               delegate: self)
        self.passwordTextField.delegate = textFieldDelegate
        self.confirmPasswordTextField.delegate = textFieldDelegate
    }
    
    @IBAction func register() {
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
    
    func updateRegisterButtonFromValidation(enable: Bool) {
        self.registerButton.isEnabled = enable
        
        let alpha: CGFloat = enable ? 1.0 : 0.4
        self.registerButton.alpha = alpha
    }
    
    func passwordFieldsValidated(success: Bool) {
        self.updateRegisterButtonFromValidation(enable: success)
    }
}

