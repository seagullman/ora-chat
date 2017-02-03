//
//  ChatsTableViewCellViewModel.swift
//  Ora-Chat
//
//  Created by Brad Siegel on 2/2/17.
//  Copyright © 2017 Brad Siegel. All rights reserved.
//

import Foundation

class ChatsTableViewCellViewModel {
    
    let chat: Chat
    
    init(chat: Chat) {
        self.chat = chat
    }
    
    var chatTitle: String {
        return self.chat.name 
    }
    
    var senderText: String {
        return "\(self.chat.last_chat_message!.user.name) - \(self.elapsedTimeSinceMessage) ago"
    }
    
    var lastMessageText: String {
        return self.chat.last_chat_message?.message ?? ""
    }
    
    fileprivate var elapsedTimeSinceMessage: String {
        return "2 hours ago"
    }
}
