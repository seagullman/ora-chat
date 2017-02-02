//
//  AccountView.swift
//  Ora-Chat
//
//  Created by Brad Siegel on 2/2/17.
//  Copyright © 2017 Brad Siegel. All rights reserved.
//

import UIKit

class AccountView: UIView {
    
    var delegate: AccountDelegate?
    
    @IBAction func logout() {
        self.delegate?.logout()
    }
}
