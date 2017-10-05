//
//  MultipleChoiceViewController.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 31/08/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
//


import UIKit

class MultipleChoiceViewController: QuestionViewController {
    

    
    var submitCounter : Int = 0
    //@IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var multipleQuestionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var questionLabel: UILabel!
    // MARK: VDL
    


    
    override func viewDidLoad() {
        super.viewDidLoad()

        let defaults = UserDefaults.standard
        //self.questionLabel.text = "questiona are ae lsdjfsjlkfjl kjlfsdlfj lsjflsj questiona are ae lsdjfsjlkfjl kjlfsdlfj lsjflsj questiona are ae lsdjfsjlkfjl kjlfsdlfj lsjflsj questiona are  "
        self.questionLabel.text = defaults.value(forKey: "quest") as? String
        let heightofLabel = HeightUtility.heightForView(text: self.questionLabel.text!, width: self.questionLabel.frame.width)
        multipleQuestionViewHeightConstraint.constant = heightofLabel + 300
        
        self.submitButton.alpha = 0
        giveTheNameToRespectiveLabels()
        //showSubmitButton()
    }
    
    func giveTheNameToRespectiveLabels() {
        let defaults = UserDefaults.standard
       // let sayTitleLabel = ["1":"something", "2": "sone" , "3": "sometihf" , "4":"sfsfsff"]
        let sayTitleLabel = defaults.value(forKey: "options") as! Dictionary<String,String>
        for (key, value) in sayTitleLabel.enumerated(){
            print("Item \(key): \(value)")
        }
        

        
        choiceA.setTitle(sayTitleLabel["1"], for: .normal)
        choiceB.setTitle(sayTitleLabel["2"], for: .normal)
        choiceC.setTitle(sayTitleLabel["3"], for: .normal)
        choiceD.setTitle(sayTitleLabel["4"], for: .normal)
    }
    
    //@IBOutlet weak var questionLabel: UILabel!
    
    func showSubmitButton() {
        for case let button as ISRadioButton in self.view.subviews {
            if button.isSelected == true{
                self.submitButton.alpha = 1
               print("isRadiobutton detected")
            }
            
        }
    }

    @IBOutlet weak var choiceA: ISRadioButton!
    @IBOutlet weak var choiceB: ISRadioButton!
    @IBOutlet weak var choiceC: ISRadioButton!
    @IBOutlet weak var choiceD: ISRadioButton!
    
    @IBAction func onMultipleChoiceButtonPressed(_ sender: ISRadioButton) {
        
    
        if sender.isSelected {
            submitCounter += 1
        } else {
            submitCounter -= 1
        }
        
        if submitCounter > 0 {
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                
                self.submitButton.alpha = 1.0
            }) { (isCompleted) in
                self.submitButton.alpha = 1.0
            }

        }else {
            self.submitButton.alpha = 0
        }
        
        //print(multipleRadioButton)
    }



    @IBOutlet weak var submitButton: CustomButton!
    
    func saveItToSaveManager() {
        SaveManager.sharedInstance().saveChoiceForMultipleChoice(multipleChoiceArray: createTheListOfSelectedButtonNames())
    }
    
    
    @IBAction func onSubmitButtonPressed(_ sender: UIButton) {
        onSubmitButtonPressedAction()   
    }
    
    func createTheListOfSelectedButtonNames() -> [String:String] {
        var list = [String:String]()
        
        if (choiceA.isSelected) {
            //list.append((choiceA.titleLabel?.text)!)
//            list.append ("1")
            list["1"] = (choiceA.titleLabel?.text)!
        }
        if (choiceB.isSelected) {
            //list.append((choiceB.titleLabel?.text)!)
//            list.append ("2")
            list["2"] = (choiceB.titleLabel?.text)!
        }
        if (choiceC.isSelected) {
            //list.append((choiceC.titleLabel?.text)!)
//            list.append ("3")
            list["3"] = (choiceC.titleLabel?.text)!

        }
        if (choiceD.isSelected) {
            //list.append((choiceD.titleLabel?.text)!)
//            list.append ("4")
            list["4"] = (choiceD.titleLabel?.text)!

        }
        
        return list
    }

}
