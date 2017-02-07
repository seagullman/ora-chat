//
//  LandingController.swift
//  Ora-Chat
//
//  Created by Brad Siegel on 2/1/17.
//  Copyright © 2017 Brad Siegel. All rights reserved.
//

import UIKit

protocol LandingDelegate: class {
    func didSelectChat(chatId: Int, atIndex: Int)
}

class LandingController: UIViewController,
                         LandingDelegate {
    
    @IBOutlet private var landingView: LandingView!
    
    private let networkClient = NetworkClient()
    
    private var selectedChatId: Int?
    private var selectedChatIndex: Int?
    private var landingViewModel: LandingViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.navigationItem.hidesBackButton = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.landingView.delegate = self
        
        networkClient.getChats { (chats) in
            let viewModel = LandingViewModel(chats: chats)
            self.landingViewModel = viewModel
            self.landingView.displayViewModel(viewModel: viewModel)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ChatDetailController,
            let id = self.selectedChatId,
            let selectedIndex = self.selectedChatIndex,
            let chatName = self.landingViewModel?.chats[selectedIndex].name {
            destination.chatId = id
            destination.chatName = chatName
        }
    }
    
    //MARK: LandingDelegate
    func didSelectChat(chatId: Int, atIndex: Int) {
        self.selectedChatId = chatId
        self.selectedChatIndex = atIndex
        self.performSegue(withIdentifier: "chatDetailSegue",
                          sender: self)
    }
}
