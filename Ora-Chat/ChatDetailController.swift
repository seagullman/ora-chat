//
//  ChatDetailController.swift
//  Ora-Chat
//
//  Created by Brad Siegel on 2/6/17.
//  Copyright © 2017 Brad Siegel. All rights reserved.
//

import UIKit
import SlackTextViewController

class ChatDetailController: SLKTextViewController {

    @IBOutlet private var chatDetailView: ChatDetailView!
    
    let networkClient = NetworkClient()
    var chatId: Int?
    var chatDetailViewModel: ChatDetailViewModel?
    
    @IBOutlet weak var testLabel: UILabel!
    
    override class func tableViewStyle(for decoder: NSCoder) -> UITableViewStyle {
        return .plain
    }
    
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count =  self.chatDetailViewModel?.messages.count ?? 0
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatDetailMessageTableViewCell.reuseIdentifier, for: indexPath) as! ChatDetailMessageTableViewCell

        let messageModelAtIndexPath = chatDetailViewModel?.messages[indexPath.row]
        
        cell.messageText.text = messageModelAtIndexPath?.message
        cell.messageDate.text = "\(messageModelAtIndexPath?.created_at)"
        cell.transform = tableView.transform
        
        return cell
    }
    
    private func configureTableView() {
        self.registerPrefixes(forAutoCompletion: [""])
        self.tableView?.register(
            UINib(nibName: "ChatDetailMessageTableViewCell",
                  bundle: nil),
            forCellReuseIdentifier: ChatDetailMessageTableViewCell.reuseIdentifier)
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.estimatedRowHeight = 50.0
        isInverted = true

    }
    
    override func didPressRightButton(_ sender: Any?) {
        print("send button tapped")
    }
}
