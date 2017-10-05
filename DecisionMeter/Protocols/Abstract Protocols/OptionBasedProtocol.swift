//
//  OptionBasedProtocol.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 27/09/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
//

import Foundation

@objc protocol OptionBasedProtocol {
    
 @objc optional   func attributesSavedForOptionBased(questionId:String, questionString:String, questionType:String)
    
    func onSubmitButtonPressedAction()
}
