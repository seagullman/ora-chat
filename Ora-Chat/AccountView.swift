//
//  AccountView.swift
//  Ora-Chat
//
//  Created by Brad Siegel on 2/2/17.
//  Copyright © 2017 Brad Siegel. All rights reserved.
//

import UIKit

class AccountView: UIView {
    
    @IBOutlet fileprivate weak var nameTextField: UITextField!
    @IBOutlet fileprivate weak var emailTextField: UITextField!
    @IBOutlet fileprivate weak var passwordTextField: UITextField!
    @IBOutlet fileprivate weak var confirmPasswordTextField: UITextField!
    
    var delegate: AccountDelegate?
    
    func displayViewModel(viewModel: AccountViewModel) {
        self.nameTextField.text = viewModel.name
        self.emailTextField.text = viewModel.email
    }
    
    @IBAction func logout() {
        self.delegate?.logout()
    }
}
