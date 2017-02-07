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
}

class ChatDetailMessageTableViewCell: UITableViewCell {

    static let reuseIdentifier = "message_TableView_cell"
    
    @IBOutlet weak var messageText: UILabel!
    @IBOutlet weak var messageDate: UILabel!
    @IBOutlet weak var messageView: UIView!
    
    override func awakeFromNib() {
        self.messageView.layer.cornerRadius = 15.0
    }
    
    func displayViewModel(viewModel: ChatDetailCellViewModel) {
        self.messageText.text = viewModel.message
        self.messageDate.text = viewModel.date.formattedDate()
    }
}
