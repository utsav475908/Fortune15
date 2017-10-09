 
 //  ViewController.swift
 //  DecisionMeter
 //
 //  Created by Avishek Sinha on 31/08/17.
 //  Copyright © 2017 Avishek Sinha. All rights reserved.
 //
 
 
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
    
    fileprivate func checkForSession404(_ arrayElementsGot: [String : AnyObject], _ kQuestionUnAvailable: String, _ kSessionUnavailable: String, _ kQuestionAnswered: String) {
        
        guard  arrayElementsGot["status"]?.int64Value == 404 else {return}
            // MARK:// Question is NOT Available
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
            // MARK:// Session is NOT Available
            if arrayElementsGot["message"] as! String == kSessionUnavailable {
                let alertVC =  UIAlertController.alertWithTitle(title: "No Session", message: "Session is not Available", buttonTitle: "Ok")
                DispatchQueue.main.async {
                    self.present(alertVC, animated: true, completion: nil)
                }
                return
            }
            // MARK:// Question is ALREADY Answered
            if  arrayElementsGot["message"] as! String  == kQuestionAnswered {
                questionIdIncrement()
                
                let session = TokenManager.sharedInstance().getToken()
                
                print("critical")
                Http.httpRequest(session: session, viewController:self , searchNext: true)
                return
            }
            print("Raise error")
            
            DispatchQueue.main.async {
                self.attendeeLabel.textColor = UIColor.red
                self.attendeeLabel.font = UIFont.agileDecisionFont()
                self.attendeeLabel.text = "Enter correct token"
            }
            
        
    
    }
    
    @objc func dataDownloaded(notification:NSNotification) {
        let kQuestionUnAvailable = "QUESTION_UNAVAILABLE"
        let kQuestionAnswered = "QUESTION_ALREADY_ANSWERED"
        let kSessionUnavailable = "SESSION_UNAVAILABLE"
        
        if let arrayElementsGot = notification.userInfo as? Dictionary<String,AnyObject> {
            
            
            checkForSession404(arrayElementsGot, kQuestionUnAvailable, kSessionUnavailable, kQuestionAnswered)
            checkForSession500(arrayElementsGot)
            //routeOnSuccess(arrayElementsGot)
            routeToViewControllerIfTheStatusCodeIs200(arrayElementsGot)
            
        }
        
    }
    
    func routeToViewControllerIfTheStatusCodeIs200(_ arrayElementsGot: [String : AnyObject]) {

        if arrayElementsGot["status"] == nil{
            routeOnSuccess(arrayElementsGot)
        }
        return
    }
    
    func routeOnSuccess(_ arrayElementsGot: [String : AnyObject]){
        TokenManager.sharedInstance().saveTheQuestionsAndOptions(arrayElementsGot: arrayElementsGot)
        
        DispatchQueue.main.async {
            self.router?.invokeTheSegueAfterTheWebService(navigationKey: TokenManager.sharedInstance().getTheNavigationKey(), givenViewController: self)
        }
    }
    
    func checkForSession500(_ arrayElementsGot: [String : AnyObject]){
//        guard arrayElementsGot["status"]?.int64Value == 500 {
//            // MARK:// Question is NOT Available
//            DispatchQueue.main.async {
//                let alert500VC =  UIAlertController.alertWithTitle(title: "Internal Server Error", message: "Code 500", buttonTitle: "OK")
//                self.present(alert500VC, animated: true, completion: nil)
//            }
//
//        }else {return}
        
        guard arrayElementsGot["status"]?.int64Value == 500 else {return}
        
        DispatchQueue.main.async {
                            let alert500VC =  UIAlertController.alertWithTitle(title: "Internal Server Error", message: "Code 500", buttonTitle: "OK")
                            self.present(alert500VC, animated: true, completion: nil)
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
        addedListOfNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loginviewcontroller" + serverEndPointURL)
        self.tokenTextField.borderStyle = UITextBorderStyle.roundedRect 
        respondToTokenTextField()
        
    }
    
 }
 
