//
//  Extensions.swift
//  Ora-Chat
//
//  Created by Brad Siegel on 2/2/17.
//  Copyright © 2017 Brad Siegel. All rights reserved.
//
import UIKit

extension UIViewController {
    func hideKeyboardOnTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension Date {
    func dateFromString(dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
        return dateFormatter.date(from: dateString) ?? Date()
    }
    
    func formattedDate() -> String {
        let dateFormate = DateFormatter()
        dateFormate.dateFormat = "MMM d, H:mm a"
        return dateFormate.string(from: self)
    }
    
    func formattedTimeSinceNow() -> String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute]
        formatter.unitsStyle = .abbreviated
        let string = formatter.string(from: self,
                                      to: Date())
        return string
    }
}
