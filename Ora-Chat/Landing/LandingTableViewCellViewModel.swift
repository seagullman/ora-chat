//
//  LandingTableViewCellViewModel.swift
//  Ora-Chat
//
//  Created by Brad Siegel on 2/2/17.
//  Copyright © 2017 Brad Siegel. All rights reserved.
//

import Foundation

class LandingTableViewCellViewModel {
    
    let chat: Chat
    
    init(chat: Chat) {
        self.chat = chat
    }
    
    var chatTitle: String {
        return self.chat.name 
    }
    
    var senderText: String {
        return "\(self.chat.last_chat_message!.user.name) - \(self.elapsedTimeSinceMessage)"
    }
    
    var lastMessageText: String {
        return self.chat.last_chat_message?.message ?? ""
    }
    
    private var elapsedTimeSinceMessage: String {
        let fromDate = self.chat.last_chat_message?.created_at ?? Date()
        let elapsedTime = fromDate.formattedTimeSinceNow() ?? ""
        
        return "\(elapsedTime) ago"
    }
}
