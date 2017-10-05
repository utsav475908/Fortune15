////
////  ViewRouter.swift
////  DecisionMeter
////
////  Created by Avishek Sinha on 15/09/17.
////  Copyright © 2017 Avishek Sinha. All rights reserved.
////
//
//import Foundation
//import UIKit
//
class ViewRouter {
    
    func invokeTheSegueAfterTheWebService (navigationKey:String, givenViewController:UIViewController) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let returnVC : UIViewController
        
        
        switch navigationKey {
            
        case QuestionTypeConstants.MULTIPLE_CHOICE:
            returnVC =  storyboard.instantiateViewController(withIdentifier: SegueConstants.multiple) as! MultipleChoiceViewController
        case QuestionTypeConstants.SINGLE_OPTION:
            returnVC =   storyboard.instantiateViewController(withIdentifier: SegueConstants.single) as! SingleChoiceViewController
        case QuestionTypeConstants.RATING:
            returnVC =   storyboard.instantiateViewController(withIdentifier: SegueConstants.range) as! RatingViewController
        case QuestionTypeConstants.SLIDER:
            returnVC = storyboard.instantiateViewController(withIdentifier: SegueConstants.slider) as! RangeViewController
            
        default:
            returnVC =  storyboard.instantiateViewController(withIdentifier: SegueConstants.waiting) as! WaitingViewController
            
        }
        
        DispatchQueue.main.async {
            
            givenViewController.present(returnVC, animated: true, completion: nil)
            
        }
        
    }
    
}

