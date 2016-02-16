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

class API
{
    static let shared = API()
    
    let container: CKContainer
    let database: CKDatabase
    
    private init()
    {
        self.container = CKContainer.defaultContainer()
        self.database = self.container.privateCloudDatabase         //Only the user can access data
    }
    
    func POST(post: Post, completion: APICompletion) {
        do {
            if let record = try Post.recordWith(post) {
                self.database.saveRecord(record, completionHandler: { (record, error) -? Void in
                    if erro == nil {
                        print(record)
                        completion(success: true) }
                    } catch {
                    
                }
            }
        }
    }
