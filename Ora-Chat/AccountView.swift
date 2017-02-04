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
    @IBOutlet fileprivate weak var editDoneButton: UIButton!
    @IBOutlet fileprivate weak var saveButton: UIButton!
    @IBOutlet fileprivate weak var savedBanner: UIView!
    
    @IBOutlet fileprivate weak var savedBannerTopSpace: NSLayoutConstraint!
    var delegate: AccountDelegate?
    
    func displayViewModel(viewModel: AccountViewModel) {
        self.nameTextField.text = viewModel.name
        self.emailTextField.text = viewModel.email
    }
    
    @IBAction func updateUser() {
        self.saveButton.isEnabled = false
        self.update()
    }
    
//    @IBAction func enableEditing() {
//        self.nameTextField.isEnabled = !self.nameTextField.isEnabled
//        self.emailTextField.isEnabled = !self.emailTextField.isEnabled
//        self.passwordTextField.isEnabled = !self.passwordTextField.isEnabled
//        self.confirmPasswordTextField.isEnabled = !self.confirmPasswordTextField.isEnabled
//        let buttonText = nameTextField.isEnabled ? "done" : "edit"
//        self.editDoneButton.setTitle(buttonText, for: .normal)
//        if !self.nameTextField.isEnabled {
//            self.update()
//        }
//    }
    
    @IBAction func logout() {
        self.delegate?.logout()
    }
    
    private func update() {
        //TODO validate so fields cannot be empty, then force unwrap
    let name = self.nameTextField.text ?? ""
    let email = self.emailTextField.text ?? ""
    let password = self.passwordTextField.text ?? ""
    
    self.delegate?.updateUser(name: name, email: email, password: password, completion: {
        self.savedBanner.alpha = 1.0
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
}
