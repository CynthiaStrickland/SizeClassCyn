//
//  Post.swift
//  SizeClassCyn
//
//  Created by Cynthia Whitlatch on 2/16/16.
//  Copyright © 2016 Cynthia Whitlatch. All rights reserved.
//

import Foundation
import UIKit
import CloudKit


class Post {
    var image: UIImage
    
    init(image: UIImage) {
        self.image = image
    }
}

enum PostError: ErrorType               //must conform to errorType
{
    case WritingImage
    case CKRecord
}

extension Post {
    class func recordWith(post: Post) throws -> CKrecord? {
        let imageURL = NSURL.imageURL()
        guard let data = UIImageJPEGRepresentation(post.image, 0.8) else { throw PostError.WritingImage }
        let saved = data.writeToURL(imageURL, atomically: true)
        
        if saved {
            let asset = CKAsset(fileURL: imageURL)
            let record = CKRecord(recordType: "Post")
            
            record.setObject(asset, forKey: "Image")
            
            return record } else {throw PostError.CKRecord}
        
        }
    }
