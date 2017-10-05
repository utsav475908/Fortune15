//
//  Http.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 04/09/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
//

import Foundation

let dataGotNotificationName = Notification.Name("DataReceived")

struct Http{
    
    //static let UUID = UIDevice.current.identifierForVendor!.uuidString
    //static let UUID = UIDevice.current.uniqueDeviceIdentifier()! + String(describing: UIDevice.current.identifierForVendor)
    // Get Method
//    static let UUID = UIDevice.current.uniqueDeviceIdentifier()!
    // Go to the Enviroments.swift
    
    
    static func questionIdReset() {
        let defaults = UserDefaults.standard
        defaults.set("1", forKey: "questionId")
        defaults.synchronize()
    }
    
    static func switchTheURL(withSession sessionString:String, searchNext:Bool = false) -> URL {
        let urlHolder:URL
        if searchNext {
            let defaults = UserDefaults.standard
            let questionNumber:Int   = Int(defaults.value(forKey: "questionId")! as! String)!
            let questionId = String(questionNumber)
            defaults.set(String(describing: questionNumber), forKey: "questionId")
            defaults.synchronize()
            
            urlHolder = URL(string: SegueConstants.baseURL + SegueConstants.appURL + "\(sessionString)/questions/\(questionId)")!
        }else {
            //urlHolder = URL(string: DecisionConstants.baseURL + DecisionConstants.appURL + "\(sessionString)/current-question")!
            questionIdReset()
            let defaults = UserDefaults.standard
            let questionID = String(describing: defaults.value(forKey: "questionId")!)
            urlHolder = URL(string: SegueConstants.baseURL + SegueConstants.appURL + "\(sessionString)/questions/\(questionID)")!
            
        }
        print("url formatted is \(urlHolder) " )
        return urlHolder
    }
    
    
    static func httpRequest(session:String, viewController:UIViewController, searchNext next:Bool = false)  {
        
        var dicList:Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
        
        
        let url = switchTheURL(withSession: session,searchNext: next)
        print(url)
        
        let session = URLSession.shared
        var  request = URLRequest(url: url)
        request.addValue(UUID!, forHTTPHeaderField: "x-request-id")
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: viewController.view, animated: true)
        }
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                print("HI I AM THE ERROR " + error!.localizedDescription)
                let vc = UIAlertController.alertWithTitle(title: "ERROR", message: "ERROR", buttonTitle: "ERROR")
                viewController.present(vc, animated: true, completion: nil)
                return
                
            }
            
            guard let data = data else {
                return
            }
            //Thread.sleep(forTimeInterval: 0.2)
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: viewController.view, animated: true)
            }
            //print("dictionary list got == \(data)")
            dicList =  dataParserFromUrl(givenData: data) as! Dictionary<String,AnyObject>
            print("dictionary list got == \(dicList)")
            //            NotificationCenter.default.post(name: dataGotNotificationName, object: nil, userInfo: dicList)
            postTheNotification(givenDictionary: dicList)
            //print(String.convertToDictionary(text: questions)!)
        })
        task.resume()
    }
    
    static func postTheNotification(givenDictionary dictionaryList : Dictionary<String, AnyObject>){
        NotificationCenter.default.post(name: dataGotNotificationName, object: nil, userInfo: dictionaryList)
    }
    
   
}
