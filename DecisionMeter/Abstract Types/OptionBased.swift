//
//  OptionBased.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 27/09/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
//

import Foundation

class OptionBasedQuestions {
    var questionId:String?
    var questionString:String?
    var questionType:String?
    
    init(questionId:String, questionString:String, questionType:String) {
        self.questionId  = questionId
        self.questionString = questionString
        self.questionType = questionType
    }
}
