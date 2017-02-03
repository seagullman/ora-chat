//
//  Chat.swift
//  Ora-Chat
//
//  Created by Brad Siegel on 2/2/17.
//  Copyright © 2017 Brad Siegel. All rights reserved.
//

import Foundation

class Chat: NSObject {
    let id: Int
    let name: String
    var users: [User] = []
    var last_chat_message: ChatMessage?
    
    init(dict: [String: AnyObject]) {
        self.id = dict["id"] as? Int ?? 0
        self.name = dict["name"] as? String ?? ""
        
        var allUsers: [User] = []
        if let usersJson = dict["users"] {
            for index in 0...usersJson.count - 1 {
                guard let user = usersJson[index]  else { return }
                let parsedUser = User(dict: user as! [String : AnyObject])
                allUsers.append(parsedUser)
            }
        }
        self.users = allUsers
        self.last_chat_message = ChatMessage(dict: dict["last_chat_message"] as! [String : AnyObject])
    }
}

