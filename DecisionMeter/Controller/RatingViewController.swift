//
//  RatingViewController.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 31/08/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
//

import UIKit

class RatingViewController: QuestionViewController {
@IBOutlet weak var ratingQuestionViewHeightConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        self.questionLabel.text = defaults.value(forKey: "quest") as? String

        let height = HeightUtility.heightForView(text: self.questionLabel.text!, width: self.questionLabel.frame.size.width)
        print(height)
        ratingQuestionViewHeightConstraint.constant = height + 220
      self.submitButton.alpha = 0

    }

    @IBOutlet weak var questionLabel: UILabel!
    
    //@IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var starRating: HCSStarRatingView!
    
    @IBAction func ratingChanged(_ sender: HCSStarRatingView) {
        UIView.animate(withDuration: 0.75, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: { 
            self.submitButton.alpha = 1
        }) { (completed) in
            self.submitButton.alpha = 1 
        }
    }
    @IBOutlet weak var submitButton: CustomButton!
 

    
    @IBAction func onSubmitButtonPressed(_ sender: UIButton) {
        onSubmitButtonPressedAction()
    }
    
    func saveTheRatingsValue() {
        SaveManager.sharedInstance().saveRatings(ratingString:Int(starRating.value))
    }
    


}
