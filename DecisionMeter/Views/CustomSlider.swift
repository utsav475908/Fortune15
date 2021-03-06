//
//  CustomSlider.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 04/09/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
//

import UIKit



    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBDesignable 
    open class CustomSlider : UISlider {
        @IBInspectable open var trackWidth:CGFloat = 2 {
            didSet {setNeedsDisplay()}
        }
        
        override open func trackRect(forBounds bounds: CGRect) -> CGRect {
            let defaultBounds = super.trackRect(forBounds: bounds)
            return CGRect(
                x: defaultBounds.origin.x,
                y: defaultBounds.origin.y + defaultBounds.size.height/2 - trackWidth/2,
                width: defaultBounds.size.width,
                height: trackWidth
            )
        }
    }


