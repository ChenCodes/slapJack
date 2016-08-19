//
//  AppDelegate.swift
//  8BitSlapJack
//
//  Copyright (c) 2016 StrCat. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        var storyboard = UIStoryboard(name: "Tutorial", bundle: nil)
        
        if (!isAppAlreadyLaunchedOnce()) {
            let rootController = storyboard.instantiateViewControllerWithIdentifier("tutorialPageBegin") as UIViewController!
            //            print("first time launch! play tutorial")
            if let window = self.window {
                window.rootViewController = rootController
            }
        } else {
            storyboard = UIStoryboard(name: "Home", bundle: nil)
            let rootController = storyboard.instantiateViewControllerWithIdentifier("homePageController") as UIViewController!
            if let window = self.window {
                window.rootViewController = rootController
            }
        }
        
        return true
    }
    
    func isAppAlreadyLaunchedOnce()->Bool{
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let isAppAlreadyLaunchedOnce = defaults.stringForKey("isAppAlreadyLaunchedOnce"){
            return true
        }else{
            defaults.setBool(true, forKey: "isAppAlreadyLaunchedOnce")
            return false
        }
    }
    
    
    
    
}
