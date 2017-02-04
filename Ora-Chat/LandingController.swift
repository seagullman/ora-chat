//
//  LandingController.swift
//  Ora-Chat
//
//  Created by Brad Siegel on 2/1/17.
//  Copyright © 2017 Brad Siegel. All rights reserved.
//

import UIKit

protocol LandingDelegate: class {
    func didSelectChat(chatId: Int)
}

class LandingController: UIViewController,
                         LandingDelegate {
    
    @IBOutlet fileprivate var landingView: LandingView!
    
    fileprivate let networkClient = NetworkClient()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.navigationItem.hidesBackButton = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.landingView.delegate = self
        let navigationBarHeight: CGFloat = self.navigationController!.navigationBar.frame.height
        print("HEIGHT: \(navigationBarHeight)")
        networkClient.getChats { (chats) in
            print("LandingController chats response count: \(chats.count)")
            self.landingView.displayViewModel(viewModel: LandingViewModel(chats: chats))
        }
    }
    
    func didSelectChat(chatId: Int) {
        self.performSegue(withIdentifier: "chatDetailSegue", sender: self)
    }
}
