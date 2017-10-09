//
//  HttpPost.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 04/10/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
//

import Foundation

extension Http {
    
    // Post Method

    static func submitAction() {

        //create the url with URL
        let defauts = UserDefaults.standard
        let questionNumber = defauts.value(forKey: "questionId") as! String
        let sessionId = defauts.value(forKey: "session") as! String
        // appURL = decision-meter/sessions   and baseURL = localhost://8891
        let url = URL(string: SegueConstants.baseURL + SegueConstants.appURL + "\(sessionId)/questions/\(questionNumber)/answer")!

        let session = URLSession.shared

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        do {
            
            request.httpBody = try JSONSerialization.data(withJSONObject:passtheJSONDictionary(), options: .prettyPrinted)
            request.setValue("#c$m#876ty12itu3428$z$", forHTTPHeaderField: "x-adm-client")
            request.addValue(UUID!, forHTTPHeaderField: "x-request-id")

        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                 return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    // handle json...
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    
    
    
    static func passtheJSONDictionary() -> Dictionary<String,Any> {
        let defaults = UserDefaults.standard
        
        if defaults.value(forKey: "questionType") as! String == QuestionTypeConstants.SINGLE_OPTION{
            let doThisForSingleChoice:[String:Any] = ["requesterId": UUID,
                                                      "type": "OptionBasedAnswer" ,
                                                      "questionId": defaults.value(forKey: "questionId") as! String,
                                                      "chossedOptions":SaveManager.sharedInstance().getChoiceForSingleChoice()
                
                
            ]
            print(SaveManager.sharedInstance().getChoiceForSingleChoice())
            print(["1":SaveManager.sharedInstance().getChoiceForSingleChoice()])
            print(doThisForSingleChoice)
            
            return doThisForSingleChoice
        }
        if defaults.value(forKey: "questionType") as! String == QuestionTypeConstants.MULTIPLE_CHOICE{
            
            
            let doThisForMultipleChoice:[String:Any] = ["requesterId": UUID,
                                                        "type": "OptionBasedAnswer" ,
                                                        "questionId": defaults.value(forKey: "questionId") as! String,
                                                        "chossedOptions":SaveManager.sharedInstance().getChoiceForMultipleChoice()
            ]
            print(doThisForMultipleChoice)
            return doThisForMultipleChoice
        }
        
        
        if defaults.value(forKey: "questionType") as! String == QuestionTypeConstants.RATING{
            
            let doThisForSlider:[String:Any] = ["requesterId": UUID,
                                                "type": "ScaleBasedAnswer" ,
                                                "questionId": defaults.value(forKey: "questionId") as! String,
                                                
                                                "scale": SaveManager.sharedInstance().getRatings()
                
            ]
            print(doThisForSlider)
            return doThisForSlider
        }
        
        if defaults.value(forKey: "questionType") as! String == QuestionTypeConstants.SLIDER{
            
            
            let doThisForRange:[String:Any] = ["requesterId": UUID,
                                               "type": "ScaleBasedAnswer" ,
                                               "questionId": defaults.value(forKey: "questionId") as! String,
                                               
                                               "scale": SaveManager.sharedInstance().getSlider()
                
            ]
            print(doThisForRange)
            return doThisForRange
        }
        
        return [:]
        
    }
    
}
