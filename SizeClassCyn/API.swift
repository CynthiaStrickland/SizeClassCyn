//
//  API.swift
//  SizeClassCyn
//
//  Created by Cynthia Whitlatch on 2/16/16.
//  Copyright © 2016 Cynthia Whitlatch. All rights reserved.
//

import UIKit
import CloudKit

typealias APICompletion = (success: Bool) -> ()

class API {
    static let shared = API()
    
    let container: CKContainer
    let database: CKDatabase
    
    private init()
    {
        self.container = CKContainer.defaultContainer()
        self.database = self.container.privateCloudDatabase

        //      Obj-C version
        //CKContainer *myContainer = [CKContainer defaultContainer];
        //CKDatabase *privateDatabase = [myContainer privateCloudDatabase];

    }
    
    func aPost(post: Post, completion:APICompletion) {
        do {
            if let record = try Post.recordWith(post) {
                self.database.saveRecord(record, completionHandler: { (record, error) -> Void in
                    if error == nil {
                        print(record)
                        completion(success: true)
                    } 
                })
            }
        }
    }

    func handleIdentityChanged(notification: NSNotification) {
        
        let fileManager = NSFileManager()
        
        if let token = fileManager.ubiquityIdentityToken{
            print("The new token is \(token)")
        } else {
            print("User has logged out of iCloud")
        }

    }
}

