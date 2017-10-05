//
//  QuestionBasedProtocol.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 27/09/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
//

import Foundation


@objc protocol QuestionBasedProtocol{
   @objc optional  func attributesSavedForQuestionBased(questionId:String, questionString:String, questionType:String,options:[String:String] )
    
    func onSubmitButtonPressedAction()
}
