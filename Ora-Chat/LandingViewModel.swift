//
//  LandingViewModel.swift
//  Ora-Chat
//
//  Created by Brad Siegel on 2/3/17.
//  Copyright © 2017 Brad Siegel. All rights reserved.
//

import Foundation

class LandingViewModel: NSObject {
    
    let chats: [Chat]
    
    init(chats: [Chat]) {
        self.chats = chats.sorted(by: {
            ($0.last_chat_message?.created_at)! > ($1.last_chat_message?.created_at)! 
        })
    }
}

