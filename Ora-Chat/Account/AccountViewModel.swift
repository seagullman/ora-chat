//
//  AccountViewModel.swift
//  Ora-Chat
//
//  Created by Brad Siegel on 2/2/17.
//  Copyright © 2017 Brad Siegel. All rights reserved.
//

import Foundation

class AccountViewModel: NSObject {
    
    private let user: User
    
    init(user: User) {
        self.user = user
    }
    
    var name: String {
        return self.user.name
    }
    
    var email: String {
        return self.user.email
    }
}
