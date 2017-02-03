//
//  LandingController.swift
//  Ora-Chat
//
//  Created by Brad Siegel on 2/1/17.
//  Copyright © 2017 Brad Siegel. All rights reserved.
//

import UIKit

class LandingController: UIViewController {
    
    fileprivate let networkClient = NetworkClient()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.navigationItem.hidesBackButton = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardOnTap()
        networkClient.getChats { (chats) in
            print("LandingController chats response: \(chats.count)")
            print(chats[0].name)
            
        }
    }
    //TODO: remove this. This is what will be called upon successful logout
    @IBAction func popIt() {
        _ = self.navigationController?.popToRootViewController(animated: false)
    }
}

//extension LandingController: UITableViewDelegate {
//
//}
//
//extension LandingController: UITableViewDataSource {
//    
//    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//    }
//
//    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//    }
//}
