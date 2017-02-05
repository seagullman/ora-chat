//
//  LoginView.swift
//  Ora-Chat
//
//  Created by Brad Siegel on 2/1/17.
//  Copyright © 2017 Brad Siegel. All rights reserved.
//

import UIKit

class LoginView: UIView,
                 UITextFieldValidatorDelegate {

    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    
    var delegate: LoginDelegate?
    var textFieldDelegate: UITextFieldValidator?
    
    override func awakeFromNib() {
        self.textFieldDelegate = UITextFieldValidator(
            textFields: [emailTextField, passwordTextField],
            delegate: self)
        self.emailTextField.delegate = textFieldDelegate
        self.passwordTextField.delegate = textFieldDelegate
    }
    
    @IBAction func login() {
        let email = self.emailTextField.text ?? ""
        let password = self.passwordTextField.text ?? ""
        self.delegate?.login(email: email, password: password)
    }
    
    func resetTextFields() {
        self.passwordTextField.text = ""
        self.endEditing(true)
        self.allFieldsEntered(validated: false)
    }
    
    //MARK: UITextFieldValidatorDelegate
    func allFieldsEntered(validated: Bool) {
        self.loginButton.isEnabled = validated
        let alpha: CGFloat = validated ? 1.0 : 0.4
        self.loginButton.alpha = alpha
    }
}
