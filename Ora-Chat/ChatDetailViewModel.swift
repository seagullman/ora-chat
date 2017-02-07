//
//  ChatDetailViewModel.swift
//  Ora-Chat
//
//  Created by Brad Siegel on 2/6/17.
//  Copyright © 2017 Brad Siegel. All rights reserved.
//

import Foundation

class ChatDetailViewModel: NSObject {
    
    var messages: [ChatMessage]
    
    init(messages: [ChatMessage]) {
        self.messages = messages.sorted(by: {
            ($0.created_at) > ($1.created_at)
        })
        super.init()
    }
}
