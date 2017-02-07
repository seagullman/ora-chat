//
//  User.swift
//  Ora-Chat
//
//  Created by Brad Siegel on 2/2/17.
//  Copyright © 2017 Brad Siegel. All rights reserved.
//

import Foundation

class User: NSObject {
    let id: Int
    let name: String
    let email: String
    
    init(dict: [String: AnyObject]) {
        self.id = dict["id"] as? Int ?? 0
        self.name = dict["name"] as? String ?? ""
        self.email = dict["email"] as? String ?? ""
    }
}
