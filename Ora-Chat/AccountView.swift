//
//  AccountView.swift
//  Ora-Chat
//
//  Created by Brad Siegel on 2/2/17.
//  Copyright © 2017 Brad Siegel. All rights reserved.
//

import UIKit

class AccountView: UIView {
    
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var confirmPasswordTextField: UITextField!
    @IBOutlet private weak var saveButton: UIButton!
    @IBOutlet private weak var savedBanner: UIView!
    @IBOutlet private weak var savedBannerTopSpace: NSLayoutConstraint!
    
    var delegate: AccountDelegate?
    
    func displayViewModel(viewModel: AccountViewModel) {
        self.nameTextField.text = viewModel.name
        self.emailTextField.text = viewModel.email
    }
    
    @IBAction func updateUser() {
        self.saveButton.isEnabled = false
        let name = self.nameTextField.text ?? ""
        let email = self.emailTextField.text ?? ""
        let password = self.passwordTextField.text ?? ""
        
        self.delegate?.updateUser(name: name, email: email, password: password, completion: {
            UIView.animate(withDuration: 0.2,
                           delay: 0.0,
                           options: UIViewAnimationOptions.curveEaseOut,
                           animations: { () -> Void in
                            self.savedBannerTopSpace.constant = 0
                            self.superview?.layoutIfNeeded()
            }, completion: { (finished) -> Void in
                UIView.animate(withDuration: 1.0,
                               delay: 1.0,
                               options: UIViewAnimationOptions.curveEaseIn,
                               animations: { () -> Void in
                                self.savedBannerTopSpace.constant = -25
                                self.superview?.layoutIfNeeded()
                }, completion: { (finished) -> Void in
                    self.saveButton.isEnabled = true
                })
            })
        })
    }
    
    @IBAction func logout() {
        self.delegate?.logout()
    }
}
