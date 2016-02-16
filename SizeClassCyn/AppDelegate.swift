//
//  AppDelegate.swift
//  SizeClassCyn
//
//  Created by Cynthia Whitlatch on 2/16/16.
//  Copyright © 2016 Cynthia Whitlatch. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var ubiquityIdentityDidChangeNotificationToken: NSObjectProtocol?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

                //CHECK TO SEE IF USER IS ALREADY LOGGED INTO iCOULD
        
        if let token = NSFileManager.defaultManager().ubiquityIdentityToken {
//      let iCloudContainerURL = self.fileManager.URLForUbiquityContainerIdentifier(GroceryListConfig.iCloudID)
                return true
            } else {
                print("No iCloud access")
                return false
            }
        }
    
    /* Start listening for iCloud user change notifications */

    func applicationBecameActive(notification: NSNotification){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleIdentityChanged:", name: NSUbiquityIdentityDidChangeNotification, object: nil)
    }
}

