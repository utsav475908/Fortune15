//
//  QuestionBasedClass.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 27/09/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
//

import Foundation


class QuestionBasedClass {
    typealias Options = [String:String]
    var questionId:String?
    var questionString:String?
    var questionType:String?
    var optionBased:Options
    
    init(questionId:String, questionString:String, questionType:String, optionBased:Options) {
        self.questionId  = questionId
        self.questionString = questionString
        self.questionType = questionType
        self.optionBased = optionBased
    }
}
