//
//  MultipleChoiceViewControllerExtension.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 03/10/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
//

import Foundation

extension MultipleChoiceViewController:MultipleChoiceProtocols{
    
    //MARK:MultipleChoiceProtocol
    
    func onSubmitButtonPressedAction() {
        saveItToSaveManager()
        Http.submitAction()
        SaveManager.questionIdIncrement()
        let thisStoryboard =     UIStoryboard(name: "Main", bundle: nil)
        let submittedVC =   thisStoryboard.instantiateViewController(withIdentifier: "submitted")
        present(submittedVC, animated: true, completion: nil)
    }
    
    
}
