//
//  SingleChoiceViewControllerExtension.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 03/10/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
//

import Foundation

extension SingleChoiceViewController:SingleChoiceProtocols, SSRadioButtonControllerDelegate  {
    
    //MARK:SingleChoiceProtocol
    
    func onSubmitButtonPressedAction() {
        saveitToSaveManager()
        Http.submitAction()
        SaveManager.questionIdIncrement()
        let thisStoryboard =     UIStoryboard(name: "Main", bundle: nil)
        let submittedVC =   thisStoryboard.instantiateViewController(withIdentifier: "submitted")
        present(submittedVC, animated: true, completion: nil)
    }
    
    //MARK:SSRadioButtonControllerDelegate
    func didSelectButton(selectedButton: UIButton?) {
        
        let selectedButton = radioButtonController?.selectedButton()
        if (selectedButton != nil) {
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                
                self.submitButtonPressd.alpha = 1.0
            }) { (isCompleted) in
                self.submitButtonPressd.alpha = 1.0
            }
            
            
        }else {
            UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                
                self.submitButtonPressd.alpha = 0.0
            }) { (isCompleted) in
                self.submitButtonPressd.alpha = 0.0
            }
        }
        print(selectedButton?.titleLabel?.text! ?? "no value")
        let defaults = UserDefaults.standard
        defaults.set(selectedButton?.titleLabel?.text, forKey: "answer")
        defaults.synchronize()
    }
    
}
