//
//  SingleChoiceViewController.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 31/08/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
// LOOKS OUT THE OPTIOS FROM THE WEBSERVICE AND DO THE THING .. TO DO  KUMAR UTSAV
// answer == answer

import UIKit

class SingleChoiceViewController: QuestionViewController {
    
    
    @IBOutlet weak var choiceA: SSRadioButton!
    @IBOutlet weak var choiceB: SSRadioButton!
    @IBOutlet weak var choiceC: SSRadioButton!
    @IBOutlet weak var choiceD: SSRadioButton!
 
    @IBOutlet weak var questionLabel: UILabel!
    
    var radioButtonController:SSRadioButtonsController?
    @IBOutlet weak var singleQuestionViewHeightConstraint: NSLayoutConstraint!
  
    

    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        
        self.questionLabel.text = defaults.value(forKey: "quest") as? String

        
        let heightofLabel = HeightUtility.heightForView(text: self.questionLabel.text!, width: self.questionLabel.frame.width)
        singleQuestionViewHeightConstraint.constant = heightofLabel + 290
        
        
        let questionDictionary = defaults.value(forKey: "options") as! [String:String]


        choiceA.setTitle(questionDictionary["1"], for: .normal)
        choiceB.setTitle(questionDictionary["2"], for: .normal)
        choiceC.setTitle(questionDictionary["3"], for: .normal)
        choiceD.setTitle(questionDictionary["4"], for: .normal)
        
    
        let spaceA = "    " + (choiceA.titleLabel?.text!)!
        let spaceB = "    " + (choiceB.titleLabel?.text!)!
        let spaceC = "    " + (choiceC.titleLabel?.text!)!
        let spaceD = "    " + (choiceD.titleLabel?.text!)!
        
        choiceA.titleLabel?.text = spaceA
        choiceB.titleLabel?.text = spaceB
        choiceC.titleLabel?.text = spaceC
        choiceD.titleLabel?.text = spaceD 
        
        
        
        
        
        self.submitButtonPressd.alpha = 0
        
        radioButtonController = SSRadioButtonsController(buttons: choiceA, choiceB, choiceC, choiceD)
        radioButtonController!.delegate = self;
        radioButtonController!.shouldLetDeSelect = true

      
    }
    

    
    func saveForTheSingleChoiceVC() -> [String : String ] {
      return [String(describing: radioButtonController!
        .selectedButton()!.tag): (radioButtonController?.selectedButton()?.titleLabel?.text!)!]
    }
    
    func saveitToSaveManager() {
        SaveManager.sharedInstance().saveChoiceForSingleChoice(choiceStringText: saveForTheSingleChoiceVC())
    }
   
    

    @IBOutlet weak var submitButtonPressd: CustomButton!
    
    @IBAction func onSubmitButtonPressed(_ sender: CustomButton) {
        onSubmitButtonPressedAction()
    }
    


}
