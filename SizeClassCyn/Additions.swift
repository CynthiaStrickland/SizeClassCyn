//
//  Additions.swift
//  SizeClassCyn
//
//  Created by Cynthia Whitlatch on 2/16/16.
//  Copyright © 2016 Cynthia Whitlatch. All rights reserved.
//

import Foundation
import UIKit

extension  UIImage {
    
    class func resize(image: UIImage, size: CGSize) -> UIImage {        //Can add a throw which is assuming resizing succeeds
        
        UIGraphicsBeginImageContext(size)
        let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        image.drawInRect(rect)
        
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsGetCurrentContext()
        
//        defer {
//            UIGraphicsGetCurrentContext()
//            
//        }                 Clean up block.   This replaces let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
//                                                          UIGraphicsGetCurrentContext()
        
        return resizedImage
    }
}

extension NSURL {
    
    class func imageURL() -> NSURL {        //Need a physically stored image before we can upload it.  Related to iCloudKit
    
    guard let documentsDirectory = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first else { fatalError()}
    return documentsDirectory
    }
}