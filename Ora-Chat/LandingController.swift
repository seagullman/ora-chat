//
//  LandingController.swift
//  Ora-Chat
//
//  Created by Brad Siegel on 2/1/17.
//  Copyright © 2017 Brad Siegel. All rights reserved.
//

import UIKit

class LandingController: UIViewController {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.navigationItem.hidesBackButton = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardOnTap()
    }
    //TODO: remove this. This is what will be called upon successful logout
    @IBAction func popIt() {
        _ = self.navigationController?.popToRootViewController(animated: false)
    }
}
