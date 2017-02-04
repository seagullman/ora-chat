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
    var textViewDelegate: PasswordFieldValidator?
    
    override func awakeFromNib() {
        self.textViewDelegate = PasswordFieldValidator(passwordField: self.passwordTextField,
                                               confirmationTextField: self.confirmPasswordTextField,
                                               delegate: self)
        self.passwordTextField.delegate = textViewDelegate
        self.confirmPasswordTextField.delegate = textViewDelegate
    }
    
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
    func enableRegisterButton(enable : Bool) {
        self.registerButton.isEnabled = enable
        let enabledColor = UIColor(red:1.00, green:0.25, blue:0.00, alpha:1.0)
        let disabledColor = UIColor(red:1.00, green:0.25, blue:0.00, alpha: 0.4)
        let buttonBackgroundColor = enable ? enabledColor : disabledColor
        self.registerButton.backgroundColor = buttonBackgroundColor
    }
    
    func passwordFieldsValidated(success: Bool) {
        self.enableRegisterButton(enable: success)
    }
}

