//
//  UITextFieldValidator.swift
//  Ora-Chat
//
//  Created by Brad Siegel on 2/4/17.
//  Copyright © 2017 Brad Siegel. All rights reserved.
//

protocol UITextFieldValidatorDelegate {
    func allFieldsEntered(validated: Bool)
}

import UIKit

class UITextFieldValidator: NSObject,
                            UITextFieldDelegate {
    
    let textFields: [UITextField]
    let delegate: UITextFieldValidatorDelegate
    
    init(textFields: [UITextField],
         delegate: UITextFieldValidatorDelegate ) {
        
        self.textFields = textFields
        self.delegate = delegate
        super.init()
        
        self.textFields.forEach({ (field) in
            field.addTarget(self, action:#selector(PasswordFieldValidator.textChanged), for:UIControlEvents.editingChanged)
        })
    }
    
    func textChanged() {
        var fieldsValidated: Bool = false
        
        for field in self.textFields {
            guard let empty = field.text?.isEmpty else { return }
            if empty {
                fieldsValidated = false
                break
            } else {
                fieldsValidated = true
            }
        }
        self.delegate.allFieldsEntered(validated: fieldsValidated)
    }
}


