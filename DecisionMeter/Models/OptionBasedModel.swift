//
//  OptionBasedModel.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 14/09/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
//

import Foundation

struct OptionBasedModel {
    var type:String
    var chossedOptions:[String:String]
    var questionId:String

    init(type:String = "OptionBasedAnswer", chossedOptions:[String:String] = ["1" : "1"], questionId:String = "1" ) {
        self.type = type
        self.chossedOptions = chossedOptions
        self.questionId = questionId
    }

}
