//
//  ChatDetailController.swift
//  Ora-Chat
//
//  Created by Brad Siegel on 2/6/17.
//  Copyright © 2017 Brad Siegel. All rights reserved.
//

import UIKit

class ChatDetailController: UIViewController {

    let networkClient = NetworkClient()
    var chatId: Int?
    
    
    @IBOutlet weak var testLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.testLabel.text = "ChatID: \(chatId)"
        guard let chatId = chatId else { return }
        self.networkClient.getChatMessagesFor(chatId: chatId, page: 1, limit: 49) { (chatMessages) in
            //TODO: display all chatmessages
            print("COUNT OF CHAT MESSAGES : \(chatMessages.count)")
        }
    }
}
