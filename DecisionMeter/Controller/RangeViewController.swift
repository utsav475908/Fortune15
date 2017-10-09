//
//  RangeViewController.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 31/08/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
//

import UIKit

class RangeViewController: QuestionViewController {
    var revereSliderValue:Int = 1
    
    @IBOutlet weak var rangeQuestionViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // according to the requirements I am setting this sliderValuePointer to alpha value 0 Kumar Utsav
        
        sliderValuePointer.alpha = 0
        let defaults = UserDefaults.standard
        self.questionLabel.text = defaults.value(forKey: "quest") as? String

        let height = HeightUtility.heightForView(text: self.questionLabel.text!, width: self.questionLabel.frame.size.width)
        print(height)
        
        rangeQuestionViewHeightConstraint.constant = height + 250
        self.submitButton.alpha = 0

    }

    
    @IBOutlet weak var questionLabel: UILabel!
    //@IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scaleShow: CustomSlider!
    @IBOutlet weak var sliderValuePointer: UILabel!
    @IBOutlet weak var submitButton: CustomButton!
    
    //MARK:HEIGHT FOR THE VIEW

    func showSubmitButton() {
        UIView.animate(withDuration: 0.75, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            
            self.submitButton.alpha = 1.0
        }) { (isCompleted) in
            self.submitButton.alpha = 1.0
        }
    }
    
    @IBAction func ratingSliderChanged(sender: CustomSlider) {
        showSubmitButton()
        sender.isContinuous = false;
        var currentStringValue:String = "1"
        let tracRect:CGRect = scaleShow.trackRect(forBounds: scaleShow.bounds)
        let thumbRect:CGRect = scaleShow.thumbRect(forBounds: scaleShow.bounds, trackRect: tracRect, value: scaleShow.value)

        sliderValuePointer.center = CGPoint(x: thumbRect.origin.x + scaleShow.frame.origin.x, y: scaleShow.frame.origin.y - 20)
        
        DispatchQueue.global(qos: .background).async {
            
            
            //print(revereSliderValue)
            print("This is run on the background queue")
            
            DispatchQueue.main.async {
                self.revereSliderValue = Int(floor((floor(sender.maximumValue ) + 1) - floor(sender.value + 0.5)))
                currentStringValue = String(self.revereSliderValue)
                print("This is run on the main queue, after the previous code in outer block")
                sender.setValue(Float(lround(Double(self.scaleShow.value))), animated: true)
                self.sliderValuePointer.text = currentStringValue
               
            }
        }
        

        
    }
    
    func saveTheCallMethodForSliderForPost(sliderValue:Int) {
        SaveManager.sharedInstance().saveSlider(sliderString: sliderValue)
    }

    @IBAction func onSubmitButtonPressed(_ sender: UIButton) {
        onSubmitButtonPressedAction()
    }
    


}
