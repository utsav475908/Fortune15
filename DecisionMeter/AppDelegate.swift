//
//  AppDelegate.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 31/08/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func platform() -> String {
        var sysinfo = utsname()
        uname(&sysinfo) // ignore return value
        return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        print(self.platform())
        
        self.setDomainEnvironment()
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func setDomainEnvironment() {
        let config = Bundle.main.object(forInfoDictionaryKey: "Config") as! String
        let bundleId = Bundle.main.bundleIdentifier!
        
        
        
        #if Debug
          serverEndPointURL = "http://localhost:8891"
        #elseif Testing
            serverEndPointURL = "http://dd7f92af.ngrok.io"
        
        #elseif Staging
            serverEndPointURL = "http://localhost:8891"
        
        #elseif Release
            serverEndPointURL = "http://sgscaiu0610.inedc.corpintra.net:8891"
        
        #elseif Production
            serverEndPointURL = "http://sgscaiu0610.inedc.corpintra.net:8891"
        
        #endif
        
        print(serverEndPointURL)
        print(config)
        print(bundleId)
        //https://www.youtube.com/watch?v=GrI9b9fDcys
    }

}




