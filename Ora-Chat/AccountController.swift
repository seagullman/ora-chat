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
}

class AccountController: UIViewController,
                         AccountDelegate {
    
    @IBOutlet fileprivate var accountView: AccountView! {
        didSet {
            self.accountView.delegate = self
        }
    }
    
    let networkClient = NetworkClient()
    
    func logout() {
        self.networkClient.logout { (response) in
            if response?.result.isSuccess == true {
                _ = self.navigationController?.popToRootViewController(animated: false)
            } else {
                //TODO handle logout error
            }
        }
    }
}
