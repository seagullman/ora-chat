//
//  ChatsTableViewCell.swift
//  Ora-Chat
//
//  Created by Brad Siegel on 2/2/17.
//  Copyright © 2017 Brad Siegel. All rights reserved.
//

import UIKit

class ChatsTableViewCell: UITableViewCell {
    
    @IBOutlet fileprivate weak var chatByLabel: UILabel!
    @IBOutlet fileprivate weak var lastMessageByLabel: UILabel!
    @IBOutlet fileprivate weak var lastMessageLabel: UILabel!
    
    func displayViewModel(viewModel: ChatsTableViewCellViewModel) {
        self.chatByLabel.text = viewModel.chatTitle
        self.lastMessageByLabel.text = viewModel.senderText
        self.lastMessageLabel.text = viewModel.lastMessageText
    }
}
