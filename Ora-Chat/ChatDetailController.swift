//
//  ChatDetailController.swift
//  Ora-Chat
//
//  Created by Brad Siegel on 2/6/17.
//  Copyright © 2017 Brad Siegel. All rights reserved.
//

import UIKit
import SlackTextViewController
import SwiftKeychainWrapper

class ChatDetailController: SLKTextViewController {

    @IBOutlet private var chatDetailView: ChatDetailView!
    
    let networkClient = NetworkClient()
    var chatId: Int?
    var chatDetailViewModel: ChatDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        
        guard let chatId = chatId else { return }
        self.networkClient.getChatMessagesFor(chatId: chatId,
                                              page: 1,
                                              limit: 49) { (chatMessages) in
            self.chatDetailViewModel = ChatDetailViewModel(messages: chatMessages)
            self.tableView?.reloadData()
        }
    }
    
    //MARK: UITableViewDataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //TODO: look this over agian
        let currentUserId = self.networkClient.currentUserId()
        
        
        let messageModelAtIndexPath = chatDetailViewModel?.messages[indexPath.row]
        
        if messageModelAtIndexPath?.user_id == currentUserId {
            //current user posted message, show sent cell
        } else {
            //message was not posted by current user, show recieved cell
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatDetailMessageTableViewCell.reuseIdentifier, for: indexPath) as! ChatDetailMessageTableViewCell
            
            let message = messageModelAtIndexPath?.message ?? ""
            let date = messageModelAtIndexPath?.created_at ?? Date()
            let viewModel = ChatDetailCellViewModel(
                message: message,
                date: date)
            cell.displayViewModel(viewModel: viewModel)
            cell.transform = tableView.transform
            return cell
        }

        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count =  self.chatDetailViewModel?.messages.count ?? 0
        return count
    }
    
    //MARK: private functions
    private func configureTableView() {
        self.registerPrefixes(forAutoCompletion: [""])
        self.tableView?.separatorStyle = .none
        self.tableView?.register(
            UINib(nibName: "ChatDetailMessageTableViewCell",
                  bundle: nil),
            forCellReuseIdentifier: ChatDetailMessageTableViewCell.reuseIdentifier)
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.estimatedRowHeight = 50.0
        isInverted = true

    }
    
    //MARK: overridden SLKTextViewController functions
    override class func tableViewStyle(for decoder: NSCoder) -> UITableViewStyle {
        return .plain
    }
    
    override func didPressRightButton(_ sender: Any?) {
        print("send button tapped")
        //TODO: kickoff service call to create message
    }
}
