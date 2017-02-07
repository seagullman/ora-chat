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
    
    let networkClient = NetworkClient()
    var chatId: Int?
    var chatName: String?
    var currentUserId: Int?
    var chatDetailViewModel: ChatDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
         self.currentUserId = self.networkClient.currentUserId()
        guard let chatId = self.chatId, let chatName = self.chatName else { return }
        self.navigationItem.title = chatName
        self.networkClient.getChatMessagesFor(chatId: chatId,
                                              page: 1,
                                              limit: 49) { (chatMessages) in
            self.chatDetailViewModel = ChatDetailViewModel(messages: chatMessages)
            self.tableView?.reloadData()
        }
    }
    
    //MARK: UITableViewDataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let messageModelAtIndexPath = chatDetailViewModel?.messages[indexPath.row]
        
        var cell: ChatDetailMessageTableViewCell? = nil
        if messageModelAtIndexPath?.user_id == currentUserId {
            //current user posted message, show sent cell
            cell = tableView.dequeueReusableCell(withIdentifier: ChatDetailMessageTableViewCell.sentReuseIdentifier, for: indexPath) as? ChatDetailMessageTableViewCell
        } else {
            //message was not posted by current user, show recieved cell
            cell = tableView.dequeueReusableCell(withIdentifier: ChatDetailMessageTableViewCell.reuseIdentifier, for: indexPath) as? ChatDetailMessageTableViewCell
        }
        
        guard let messageCell = cell else { return UITableViewCell() }
        
        let message = messageModelAtIndexPath?.message ?? ""
        let date = messageModelAtIndexPath?.created_at ?? Date()
        let messageAuthor = messageModelAtIndexPath?.user.name ?? ""
        
        var isMessageByCurrentUser: Bool = false
        if messageModelAtIndexPath?.user_id == self.currentUserId {
            isMessageByCurrentUser = true
        }
        
        let viewModel = ChatDetailCellViewModel(
            message: message,
            date: date,
            messageAuthor: messageAuthor,
            isMessageByCurrentUser: isMessageByCurrentUser)
        messageCell.displayViewModel(viewModel: viewModel)
        messageCell.transform = tableView.transform
        return messageCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count =  self.chatDetailViewModel?.messages.count ?? 0
        return count
    }
    
    //MARK: private functions
    private func configureTableView() {
        self.registerPrefixes(forAutoCompletion: [""])
        self.tableView?.allowsSelection = false
        self.tableView?.separatorStyle = .none
        self.tableView?.register(
            UINib(nibName: "ChatDetailReceivedMessageTableViewCell",
                  bundle: nil),
            forCellReuseIdentifier: ChatDetailMessageTableViewCell.reuseIdentifier)
        self.tableView?.register(
            UINib(nibName: "ChatDetailSentMessageTableViewCell",
                  bundle: nil),
            forCellReuseIdentifier: ChatDetailMessageTableViewCell.sentReuseIdentifier)
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.estimatedRowHeight = 50.0
        isInverted = true

    }
    
    //MARK: overridden SLKTextViewController functions
    override class func tableViewStyle(for decoder: NSCoder) -> UITableViewStyle {
        return .plain
    }
    
    /***
    *   Called when the user taps the 'send' button after typing a message in a chat
    */
    override func didPressRightButton(_ sender: Any?) {
        guard let chatId = self.chatId, let messageText = self.textInputbar.textView.text else { return }
        self.networkClient.createChatMessage(chatId: chatId, message: messageText) { (message) in
            self.chatDetailViewModel?.messages.append(message)
            self.tableView?.reloadData()
            self.textInputbar.textView.text = ""
        }
    }
}
