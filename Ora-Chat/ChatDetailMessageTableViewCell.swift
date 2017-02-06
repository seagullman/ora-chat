//
//  ChatDetailMessageTableViewCell.swift
//  Ora-Chat
//
//  Created by Brad Siegel on 2/6/17.
//  Copyright © 2017 Brad Siegel. All rights reserved.
//

import UIKit

class ChatDetailMessageTableViewCell: UITableViewCell {

    static let reuseIdentifier = "message_TableView_cell"
    
    @IBOutlet weak var messageText: UILabel!
    @IBOutlet weak var messageDate: UILabel!
}
