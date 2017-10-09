//
//  TickMarkViewController.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 12/09/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
//

import UIKit

class TickMarkViewController: QuestionViewController {
    //@IBOutlet weak var field:UITextField!
    
    var timer:Timer = Timer()
    
    func addNotificationForDownloadDataFromInternet() {
        NotificationCenter.default.addObserver(self, selector: #selector(dataDownloaded), name: dataGotNotificationName, object: nil)
    }
    
    func removeNotificationForDownloadDataFromInternet() {
        NotificationCenter.default.removeObserver(self, name: dataGotNotificationName, object: nil)
    }
    
    @objc func dataDownloaded(notifications:NSNotification) {

        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeNotificationForDownloadDataFromInternet() 
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        runTimer()
        addNotificationForDownloadDataFromInternet()
        let defaults = UserDefaults.standard
        let token = defaults.value(forKey: "session") as? String
        print(token!)

    }
    
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)

        
    }
    
    @objc func updateTimer() {
        
        loginButtonPressed(UIButton())
    }
    
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let waitingVC =   storyboard.instantiateViewController(withIdentifier: "Waiting") as! WaitingViewController
        present(waitingVC, animated: true, completion: nil)
    }
    
    
    
}
