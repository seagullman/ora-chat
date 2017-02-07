//
//  ChatDetailViewModel.swift
//  Ora-Chat
//
//  Created by Brad Siegel on 2/6/17.
//  Copyright © 2017 Brad Siegel. All rights reserved.
//

import Foundation

class ChatDetailViewModel: NSObject {
    
    private var messages: [ChatMessage]
    
    init(messages: [ChatMessage]) {
        self.messages = messages.sorted(by: {
            ($0.created_at) > ($1.created_at)
        })
        super.init()
    }
    
    var chatMessages: [ChatMessage] {
        return self.messages
    }
    
    func appendMessage(message: ChatMessage) {
        self.messages.append(message)
        self.messages = messages.sorted(by: {
            ($0.created_at) > ($1.created_at)
        })
    }
}
