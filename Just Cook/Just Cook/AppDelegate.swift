//
//  AppDelegate.swift
//  Just Cook
//
//  Created by Ilya Velilyaev on 17.03.16.
//  Copyright © 2016 Ilya Velilyaev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var viewController: ViewController?
    
    //TO BE CHANGED ON RELEASE TO FALSE!
    var firstRun: Bool = true
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        self.viewController = ViewController()
        
        self.window!.backgroundColor = UIColor.greenColor()
        self.window!.rootViewController = self.viewController
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if (defaults.objectForKey("firstRun") == nil) {
            firstRun = true
            defaults.setObject(NSDate(), forKey: "firstRun")
        }
        
        NSUserDefaults.standardUserDefaults().synchronize()
        
        let tutorialViewController = WelcomeTutorialViewController()
        
        self.window!.makeKeyAndVisible()

        
        if firstRun {
            self.viewController!.presentViewController(tutorialViewController, animated: false, completion: nil)
        }
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}
