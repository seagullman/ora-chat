//
//  ChatMessage.swift
//  Ora-Chat
//
//  Created by Brad Siegel on 2/2/17.
//  Copyright © 2017 Brad Siegel. All rights reserved.
//

import Foundation

class ChatMessage: NSObject {
    let id: Int
    let chat_id: Int
    let user_id: Int
    let message: String
    let created_at: Date
    let user: User
    
    init(dict: [String: AnyObject]) {
        self.id = dict["id"] as? Int ?? 0
        self.chat_id = dict["chat_id"] as? Int ?? 0
        self.user_id = dict["user_id"] as? Int ?? 0
        self.message = dict["message"] as? String ?? ""
        let dateString = dict["created_at"] as? String ?? ""
        self.created_at = Date().dateFromString(dateString: dateString)
        self.user = User(dict: dict["user"] as! [String : AnyObject])
    }
}
