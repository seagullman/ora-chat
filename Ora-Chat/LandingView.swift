//
//  LandingView.swift
//  Ora-Chat
//
//  Created by Brad Siegel on 2/2/17.
//  Copyright © 2017 Brad Siegel. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class LandingView: UIView {
    @IBOutlet weak var testLabel: UILabel!
    
    override func awakeFromNib() {
        let retrievedString: String? = KeychainWrapper.standard.string(forKey: "auth-token")
        //self.testLabel.text = retrievedString
    }
    
}
