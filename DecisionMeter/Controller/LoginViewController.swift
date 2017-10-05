 
//  ViewController.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 31/08/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
//

// question == question
// option == option
// session == session 

import UIKit

class LoginViewController: QuestionViewController{
    
    var navigateKey:String = String()
    var controllers:[UIViewController] = [UIViewController]()
    // 4 outlets image,label,textfield,button
    @IBOutlet weak var daimlerImageView: UIImageView!
    @IBOutlet weak var attendeeLabel: UILabel!
    @IBOutlet weak var tokenTextField: UITextField!
    @IBOutlet weak var loginButton: CustomButton!
    // action for the login button 
    
    @IBAction func loginOnSubmitButtonPressed(_ sender: CustomButton) {
       TokenManager.sharedInstance().saveToken(withToken: self.tokenTextField.text ?? "")
        DispatchQueue.main.async {
            Http.httpRequest(session: self.tokenTextField.text!, viewController: self)
        }
        
    }
    
   // invoke segue function deleted.
        
    
    

    // MARK: Notification Method calls Show
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    // MARK: Notification Method calls Hide
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        removeListOfNotifications()
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    func removeNotificationForKeyboard(){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "UIKeyboardWillShowNotification"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "UIKeyboardWillHideNotification"), object: nil)
        
    }
    
    func addNotificationForKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func respondToTokenTextField() {
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tap)
        self.loginButton.alpha = 0
        tokenTextField.delegate = self;
    }
    
    func addNotificationForDownloadDataFromInternet() {
        NotificationCenter.default.addObserver(self, selector: #selector(dataDownloaded), name: dataGotNotificationName, object: nil)
    }
    
    func removeNotificationForDownloadDataFromInternet() {
        NotificationCenter.default.removeObserver(self, name: dataGotNotificationName, object: nil)
    }
    // MARK: data downloaded callback 
    func questionIdIncrement() {
       SaveManager.questionIdIncrement()    
    }
    
    @objc func dataDownloaded(notification:NSNotification) {
        let kQuestionUnAvailable = "QUESTION_UNAVAILABLE"
        let kQuestionAnswered = "QUESTION_ALREADY_ANSWERED"
        if let arrayElementsGot = notification.userInfo as? Dictionary<String,AnyObject> {
      
            
            if  arrayElementsGot["status"]?.int64Value == 404 {
                if arrayElementsGot["message"] as! String  == kQuestionUnAvailable{
                    
                    print("question is unavailable")
                    
                    UIView.animate(withDuration: 2.75, delay: 0, options: .curveEaseIn, animations: {
                        DispatchQueue.main.async {
                            self.attendeeLabel.textColor = UIColor.orange
                            self.attendeeLabel.text = "Question is unavailable."
                            self.attendeeLabel.font = UIFont.agileDecisionFont()
                        }
                        
                    }, completion: { (complete) in
                        DispatchQueue.main.async {
                            self.attendeeLabel.text = "Enter your attendee ID"
                            self.attendeeLabel.textColor = UIColor.gray
                            self.attendeeLabel.font = UIFont.agileDecisionFont()
                        }
                        
                    })
                    return
                }
               if  arrayElementsGot["message"] as! String  == kQuestionAnswered {
                questionIdIncrement()
                //let defaults = UserDefaults.standard
                let session = TokenManager.sharedInstance().getToken()
                //let session = defaults.value(forKey: "session") as! String
                print("critical")
                Http.httpRequest(session: session, viewController:self , searchNext: true)
                return 
                }
                print("Raise error")
//                DispatchQueue.main.async {
//                     value in
//
//
//                    UIView.animate(withDuration: 0.75, delay: 0, options: .curveEaseIn, animations: {
//                        self?.attendeeLabel.textColor = UIColor.red
//                        self?.attendeeLabel.text = "Enter correct token"
//                    }, completion: { (complete) in
//                        self.attendeeLabel.text = "Enter correct token"
//                    })
//
//
//                }
                
                DispatchQueue.main.async {
                    self.attendeeLabel.textColor = UIColor.red
                    self.attendeeLabel.font = UIFont.agileDecisionFont()
                    self.attendeeLabel.text = "Enter correct token"
                }
                
            }
            

           // Token Manager
            TokenManager.sharedInstance().saveTheQuestionsAndOptions(arrayElementsGot: arrayElementsGot)

//            DispatchQueue.main.async {
//                [weak self] value in
//                //self?.invokeTheSegueAfterTheWebService(navigationKey: arrayElementsGot["questionType"]! as! String)
//                self?.router?.invokeTheSegueAfterTheWebService(navigationKey: TokenManager.sharedInstance().getTheNavigationKey(), givenViewController: self!)
//            }[weak self]
            
//            DispatchQueue.main.async {
//                 value in
//                self.router?.invokeTheSegueAfterTheWebService(navigationKey: arrayElementsGot["questionType"] as! String, givenViewController: self)
//            }
            
            DispatchQueue.main.async {
                self.router?.invokeTheSegueAfterTheWebService(navigationKey: arrayElementsGot["questionType"] as! String, givenViewController: self)
            }
            
        }
        
    }
    
    func addedListOfNotifications() {
        addNotificationForKeyboard()
        addNotificationForDownloadDataFromInternet()
    }
    
    func removeListOfNotifications() {
        removeNotificationForDownloadDataFromInternet()
        removeNotificationForKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addedListOfNotifications() // taken from the viewDidLoad , as i want this method to be called everytime it appears on screen.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loginviewcontroller" + serverEndPointURL)
        self.tokenTextField.borderStyle = UITextBorderStyle.roundedRect 
        respondToTokenTextField()
        //addedListOfNotifications()  this method is now shifted to view willAppear
        
        // delete this
        
//        #if Debug
//            serverEndPointURL = "www.google.com"
//        #elseif Testing
//            serverEndPointURL = "www.youtube.com"
//            
//        #elseif Staging
//            serverEndPointURL = "www.apple.com"
//            
//        #elseif Release
//            serverEndPointURL = "www.gmail.com"
//            
//        #elseif Production
//            serverEndPointURL = "www.yahoo.com"
//            
//        #endif

  
    }

}

