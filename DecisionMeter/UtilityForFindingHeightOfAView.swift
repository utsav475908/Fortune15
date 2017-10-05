//
//  UtilityForFindingHeightOfAView.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 03/10/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
//

import Foundation


class HeightUtility{

static func heightForView(text:String, width:CGFloat) -> CGFloat{
    let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
    label.numberOfLines = 0
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.font = UIFont(name: "CorporateS-Regular", size: 18.0)
    label.text = text
    label.sizeToFit()
    
    return label.frame.height
}
    
    
}
