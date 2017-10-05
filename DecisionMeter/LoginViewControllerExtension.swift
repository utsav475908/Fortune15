
//
//  LoginViewControllerExtension.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 28/09/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
//

import Foundation

extension LoginViewController:UITextFieldDelegate   {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true;
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        return true
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        var startString = ""
        if (textField.text != nil)
        {
            startString += textField.text!
        }
        startString += string
        let  limitNumber = startString.characters.count
        if limitNumber > 4
        {
            UIView.animate(withDuration: 0.75, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                
                self.loginButton.alpha = 1.0
            }) { (isCompleted) in
                self.loginButton.alpha = 1.0
            }
            return false
        }
        else if limitNumber == 4 {
            if self.loginButton.alpha == 1 {
                UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                    
                    self.loginButton.alpha = 0.0
                }) { (isCompleted) in
                    self.loginButton.alpha = 0.0
                }
                return true
            }
            UIView.animate(withDuration:0.75 , delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                
                self.loginButton.alpha = 1
            }) { (isCompleted) in
                self.loginButton.alpha = 1
            }
            return true;
        }
            
            
            
        else
        {
            UIView.animate(withDuration: 0.75, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                
                self.loginButton.alpha = 0
            }) { (isCompleted) in
                self.loginButton.alpha = 0
            }
            return true;
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
}
