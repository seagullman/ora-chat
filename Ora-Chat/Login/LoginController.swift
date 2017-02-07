//
//  LoginController.swift
//  Ora-Chat
//
//  Created by Brad Siegel on 2/1/17.
//  Copyright © 2017 Brad Siegel. All rights reserved.
//

import UIKit

protocol LoginDelegate {
    func login(email: String, password: String)
}

class LoginController: UIViewController,
                       LoginDelegate {

    @IBOutlet private var loginView: LoginView! {
        didSet {
            self.loginView.delegate = self
        }
    }
    
    let networkClient = NetworkClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardOnTap()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loginView.resetTextFields()
    }
    
    //MARK: LoginDelegate
    func login(email: String, password: String) {
        self.networkClient.login(email: email, password: password) { (response) in
            if response?.result.isSuccess == true {
                self.navigationController?.performSegue(withIdentifier: "landingSegue",
                                                        sender: self)
            }
        }
    }
}
