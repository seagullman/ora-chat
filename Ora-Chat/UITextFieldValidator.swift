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
/**
 *  This class takes in an array of UITextFields and notifies 
 *   the delegate when non-empty values have been entered for each UITextField.
 */
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
            field.addTarget(self,
                            action:#selector(UITextFieldValidator.validateFields),
                            for:UIControlEvents.editingChanged)
        })
    }
    
    func validateFields() {
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


