//
//  LandingTableViewCell.swift
//  Ora-Chat
//
//  Created by Brad Siegel on 2/2/17.
//  Copyright © 2017 Brad Siegel. All rights reserved.
//

import UIKit

class LandingTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var chatByLabel: UILabel!
    @IBOutlet private weak var lastMessageByLabel: UILabel!
    @IBOutlet private weak var lastMessageLabel: UILabel!
    
    func displayViewModel(viewModel: LandingTableViewCellViewModel) {
        self.chatByLabel.text = viewModel.chatTitle
        self.lastMessageByLabel.text = viewModel.senderText
        self.lastMessageLabel.text = viewModel.lastMessageText
    }
}
