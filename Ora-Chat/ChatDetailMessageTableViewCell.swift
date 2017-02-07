//
//  ChatDetailMessageTableViewCell.swift
//  Ora-Chat
//
//  Created by Brad Siegel on 2/6/17.
//  Copyright © 2017 Brad Siegel. All rights reserved.
//

import UIKit

struct ChatDetailCellViewModel {
    let message: String
    let date: Date
    let messageAuthor: String
    let isMessageByCurrentUser: Bool
}

class ChatDetailMessageTableViewCell: UITableViewCell {

    static let reuseIdentifier = "message_TableView_cell"
    static let sentReuseIdentifier = "sent_message_TableView_cell"
    
    @IBOutlet weak var messageText: UILabel!
    @IBOutlet weak var messageDate: UILabel!
    @IBOutlet weak var messageView: UIView!
    
    override func awakeFromNib() {
        self.messageView.layer.cornerRadius = 15.0
    }
    
    func displayViewModel(viewModel: ChatDetailCellViewModel) {
        self.messageText.text = viewModel.message
        if viewModel.isMessageByCurrentUser {
            self.messageDate.text = viewModel.date.formattedDate()
        } else {
            //message was not sent by current user, add user's name to field
            self.messageDate.text = "\(viewModel.messageAuthor) - \(viewModel.date.formattedDate())"
        }
    }
}
