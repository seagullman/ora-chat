//
//  AccountController.swift
//  Ora-Chat
//
//  Created by Brad Siegel on 2/2/17.
//  Copyright © 2017 Brad Siegel. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

protocol AccountDelegate: class {
    func logout()
    func updateUser(name: String, email: String, password: String, completion: @escaping () -> Void)
}

class AccountController: UIViewController,
                         AccountDelegate {
    
    @IBOutlet private var accountView: AccountView! {
        didSet {
            self.accountView.delegate = self
        }
    }
    
    let networkClient = NetworkClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardOnTap()
        _ = networkClient.currentUser { (user) in
            self.accountView.displayViewModel(viewModel: AccountViewModel(user: user))
        }
    }
    
    //MARK: AccountDelegate
    func logout() {
        self.networkClient.logout { (response) in
            if response?.result.isSuccess == true {
                _ = self.navigationController?.popToRootViewController(animated: false)
            } else {
                //TODO handle logout error
            }
        }
    }
    
    func updateUser(name: String, email: String, password: String, completion: @escaping () -> Void) {
        self.networkClient.updateUser(name: name, email: email, password: password) { (response) in
            if response?.result.isSuccess == true {
                completion()
            }
        }
    }
}
