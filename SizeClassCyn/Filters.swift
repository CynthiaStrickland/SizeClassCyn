//
//  Filters.swift
//  SizeClassCyn
//
//  Created by Cynthia Whitlatch on 2/16/16.
//  Copyright © 2016 Cynthia Whitlatch. All rights reserved.
//

import Foundation
import UIKit

typealias FiltersCompletion = (theImage: UIImage?) -> ()

class filters {
    
    //   Work on background queue
    
    
    
    private class func filterImage(name: String, image: UIImage, completion: (FiltersCompletion)) {
            NSOperationQueue().addOperationWithBlock { () -> Void in                        //Using secondary thread
            
            guard let theFilter = CIFilter(name: name) else { fatalError("Check Filter Spelling") }
            theFilter.setValue(CIImage(image:  image), forKey: kCIInputAngleKey)            //creating a filter and setting input filter
            
                //GPU Context -  We are creating
                let options = [kCIContextWorkingColorSpace : NSNull()]
                let EAGContext = EAGLContext(API: .OpenGLES2)
                let GPUContext = CIContext(EAGLContext: EAGContext, options: options)
            
            //Get the final image
            
                guard let outputImage = theFilter.outputImage else { fatalError("Why no image") }
                let CGImage = GPUContext.createCGImage(outputImage, fromRect: outputImage.extent)
                
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    completion(theImage: UIImage(CGImage: CGImage))
                })
            }
        }
    }







