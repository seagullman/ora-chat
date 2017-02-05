//
//  PasswordFieldValidator.swift
//  Ora-Chat
//
//  Created by Brad Siegel on 2/3/17.
//  Copyright © 2017 Brad Siegel. All rights reserved.
//

import UIKit

protocol PasswordFieldValidatorDelegate: class {
    func passwordFieldsValidated(success: Bool)
}

/**
 * This class is used to validate that two (password) UITextFields contain the same values.
 * The PasswordFieldValidatorDelegate is notified upon each keystroke whether or not the values match.
 */
class PasswordFieldValidator: NSObject,
                              UITextFieldDelegate {
    
    let passwordField: UITextField
    let confirmationTextField: UITextField
    var delegate: PasswordFieldValidatorDelegate
    
    init(passwordField: UITextField,
         confirmationTextField: UITextField,
         delegate: PasswordFieldValidatorDelegate ) {
        
        self.confirmationTextField = confirmationTextField
        self.passwordField = passwordField
        self.delegate = delegate
        super.init()
        
        self.passwordField.addTarget(self,
                                     action:#selector(PasswordFieldValidator.validateFields),
                                     for:UIControlEvents.editingChanged)
        self.confirmationTextField.addTarget(self,
                                             action:#selector(PasswordFieldValidator.validateFields),
                                             for:UIControlEvents.editingChanged)
    }
    
    func validateFields() {
        var a = false
        var b = false
        
        a = passwordField.text == confirmationTextField.text
        
        if(passwordField.text == "" || confirmationTextField.text == "") {
            delegate.passwordFieldsValidated(success: false)
        } else {
            b = true
        }
        
        if a == true && b == true {
            self.delegate.passwordFieldsValidated(success: true)
        } else {
            self.delegate.passwordFieldsValidated(success: false)
        }
    }
}
