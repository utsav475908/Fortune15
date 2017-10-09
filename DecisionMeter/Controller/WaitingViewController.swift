                                                                                                                                                                                                                                                                                                                                                                              //
 //  WaitingViewController.swift
 //  DecisionMeter
 //
 //  Created by Avishek Sinha on 19/09/17.
 //  Copyright © 2017 Avishek Sinha. All rights reserved.
 //
 
 import UIKit

 class WaitingViewController: QuestionViewController {
    struct TimerConstants {
        static let kTimerConstant:Int = 10
    }
    

    @IBOutlet weak var resetButton: CustomButton!
    var seconds = TimerConstants.kTimerConstant
    var timer = Timer()
    var navigationKey:String?
    var isTimerRunning = false;
    var resumeTapped = false;
    var errorCode404:Int?
    
    @IBOutlet weak var submitButton: CustomButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        //submitButton.alpha = 1.0
        runTimer()
        addNotificationForDownloadDataFromInternet()
     
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeNotificationForDownloadDataFromInternet()
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        isTimerRunning = true
       
    }

    @objc func updateTimer() {

        doThePolling()
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    func questionIdIncrement() {
        let defauts = UserDefaults.standard
        let questionNumber = defauts.value(forKey: "questionId") as! String
        let questionId = Int(questionNumber)!
        let stringQuestionId = String(questionId)
        defauts.set(stringQuestionId, forKey: "questionId")
        defauts.synchronize()
    }
    
    func doThePolling () {
        
        let token = TokenManager.sharedInstance().getToken()
         questionIdIncrement() // lets increment the question.
        Http.httpRequest(session: token, viewController: self, searchNext: true)
    }
    
    
    
    @IBAction func onSubmitButtonPressed(_ sender: CustomButton) {
        questionIdIncrement()
        doThePolling()
        
        
        //        present(vc!, animated: true, completion: nil);
    }
    
    func addGestureRecognizerForThis(){
        
        DispatchQueue.main.async {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.navigateToLoginVC(_:)))
            self.view.addGestureRecognizer(tapGesture)
            tapGesture.numberOfTapsRequired = 8
        }
        
    }
    
    @objc func navigateToLoginVC(_ sender: UITapGestureRecognizer) {
        // navigate to login vc.
        let loginVC =   storyboard?.instantiateViewController(withIdentifier: "Login") as! LoginViewController
        present(loginVC, animated: true, completion: nil)
    }
    
    @objc func hasTheQuestionIdChanged(notification:NSNotification) {
        //print(notification.userInfo as? Dictionary<String,AnyObject>!)
        if let arrayElementsGot = notification.userInfo as? Dictionary<String,AnyObject> {

            if  arrayElementsGot["status"]?.int64Value == 404 {
                print("Raise error")
                #if Debug || Testing || Staging
                  addGestureRecognizerForThis()
                    #endif
                
                return
                
                

            }

            
            // MULTIPLE_CHOICE
            
            if var errorCode404  = arrayElementsGot["status"] {
                errorCode404 = arrayElementsGot["status"]!
                print(errorCode404 as! Int )
            }
            
           TokenManager.sharedInstance().saveTheQuestionsAndOptions(arrayElementsGot: arrayElementsGot)
            DispatchQueue.main.async {
                self.router?.invokeTheSegueAfterTheWebService(navigationKey: TokenManager.sharedInstance().getTheNavigationKey(), givenViewController: self)
            }
            
        }
  
    }
    
    
    
    func presentTheViewController(viewController:UIViewController){
        if viewController is WaitingViewController {
            // do nothing
        }else {
            self.present(viewController, animated: true, completion: nil);
        }
    }
    
    
    
    
    
    func addNotificationForDownloadDataFromInternet() {
        NotificationCenter.default.addObserver(self, selector: #selector(hasTheQuestionIdChanged), name: dataGotNotificationName, object: nil)
    }
    
    func removeNotificationForDownloadDataFromInternet() {
        NotificationCenter.default.removeObserver(self, name: dataGotNotificationName, object: nil)
    }
    

    
 }
