//
//  AlertExtension.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 14/09/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
//

import Foundation

import UIKit

extension UIAlertController {
    static func alertWithTitle(title: String, message: String, buttonTitle: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
        alertController.addAction(action)
        
        return alertController
    }
}
