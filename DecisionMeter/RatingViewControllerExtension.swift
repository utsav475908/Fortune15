//
//  RatingViewControllerExtension.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 03/10/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
//

import Foundation

extension RatingViewController: RatingBasedProtocol {
    
  func   onSubmitButtonPressedAction(){
    
    saveTheRatingsValue()
    Http.submitAction()
    SaveManager.questionIdIncrement()
    let thisStoryboard =     UIStoryboard(name: "Main", bundle: nil)
    let submittedVC =   thisStoryboard.instantiateViewController(withIdentifier: "submitted")
    present(submittedVC, animated: true, completion: nil)
    
    }
}
