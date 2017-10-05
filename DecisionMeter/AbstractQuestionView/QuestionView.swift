//
//  QuestionView.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 28/09/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
//

import UIKit

let heightForWhiteLayer = 160;

@IBDesignable
class QuestionView: UIView {
    
    //var whiteLayer:CALayer = CALayer()
    
    @IBInspectable var designableDiamglerImageView:UIImageView?
    @IBInspectable var designableLogoImageView:UIImageView?
    
    
    
    @IBInspectable var viewColor:UIColor? = UIColor.red {
        didSet{
            grayColor()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        grayColor()
        
        
    }
    
    func grayColor() {
//        let boundingHeight = heightForWhiteLayer
//        let boundingWidth = UIScreen().bounds.width
//        let whiteLayerFrame = CGRect(x: 0, y: 0, width: Int(boundingWidth), height: boundingHeight)
//        
//        self.whiteLayer.frame = whiteLayerFrame
//        self.whiteLayer.backgroundColor = UIColor.white.cgColor
//        self.whiteLayer.addSublayer((designableLogoImageView?.layer)!)
//        self.whiteLayer.addSublayer((designableDiamglerImageView?.layer)!)
        self.layer.backgroundColor = viewColor?.cgColor
        //self.layer.addSublayer(whiteLayer)
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
