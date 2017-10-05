//
//  Error.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 27/09/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
//

import Foundation

struct AppError:Error {
    var status:Int
    var exception:String
    var message:Message
}
