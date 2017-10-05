//
//  Decisions.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 27/09/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
//

//["status": 404, "exception": com.daimler.dm.exception.ResourceNotFoundException, "message": QUESTION_ALREADY_ANSWERED, "timestamp": 1506508587383, "path": /decision-meter/sessions/0004/questions/3/answer, "error": Not Found]

//if let _ = arrayElementsGot["questionString"], (arrayElementsGot["questionId"] != nil), (arrayElementsGot["questionType"] != nil) {
//    defaults.set(arrayElementsGot["questionString"]!, forKey: "quest")
//    defaults.set(arrayElementsGot["questionId"]!, forKey: "questionId")
//    defaults.set(arrayElementsGot["questionType"], forKey: "questionType")
//    defaults.synchronize()
//}
//
//
//if let _ = arrayElementsGot["questionType"] {
//
//    if  arrayElementsGot["questionType"] as! String == "SINGLE_OPTION" {
//        defaults.set(arrayElementsGot["options"], forKey: "options")
//        defaults.synchronize()
//    }
//
//    if  arrayElementsGot["questionType"] as! String == "MULTIPLE_CHOICE" {
//        defaults.set(arrayElementsGot["options"], forKey: "options")
//        defaults.synchronize()
//    }
//}

//let kQuestionUnAvailable = "QUESTION_UNAVAILABLE"
//let kQuestionAnswered = "QUESTION_ALREADY_ANSWERED"



import Foundation

 protocol TokenProtocol {
    var token:String {get}
    func getToken() -> String
    func saveToken(withToken token:String )
}


class TokenManager : TokenProtocol {
    
    
    private static let instance = TokenManager()
    
    class func sharedInstance () -> TokenManager{
        return instance
    }
    

    var token: String = String()
    func getToken() -> String {
        //getting the token
        let defaults = UserDefaults.standard
        token = (defaults.value(forKey: "session") as? String)!
        print(token)
        return token
    }
    
    func saveToken(withToken token: String) {
        //saving the token
        
        let defaults = UserDefaults.standard
        
        defaults.set(token, forKey: "session")
        
        defaults.synchronize()
    }
    
    
     func saveTheQuestionsAndOptions(arrayElementsGot:Dictionary<String,AnyObject>) {
        let defaults = UserDefaults.standard
        
        if let _ = arrayElementsGot["questionString"], (arrayElementsGot["questionId"] != nil), (arrayElementsGot["questionType"] != nil) {
            defaults.set(arrayElementsGot["questionString"]!, forKey: "quest")
            defaults.set(arrayElementsGot["questionId"]!, forKey: "questionId")
            defaults.set(arrayElementsGot["questionType"], forKey: "questionType")
            defaults.synchronize()
        }
        
        
        if let _ = arrayElementsGot["questionType"] {
            
            if  arrayElementsGot["questionType"] as! String == "SINGLE_OPTION" {
                defaults.set(arrayElementsGot["options"], forKey: "options")
                defaults.synchronize()
            }
            
            if  arrayElementsGot["questionType"] as! String == "MULTIPLE_CHOICE" {
                defaults.set(arrayElementsGot["options"], forKey: "options")
                defaults.synchronize()
            }
        }
        
        
        defaults.synchronize()
    }
    
    func getTheNavigationKey() -> String {
        let defaults = UserDefaults.standard
       return  defaults.value(forKey: "questionType") as! String
    }
    
    
    
    
    
    
    
    
}
