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
    
    
    
    class func filterImage(name: String, image: UIImage, completion: (FiltersCompletion)) {
            NSOperationQueue().addOperationWithBlock { () -> Void in                        //Using secondary thread
            
            guard let filter = CIFilter(name: name) else { fatalError("Check Filter Spelling") }
            filter.setValue(CIImage(image:  image), forKey: kCIInputAngleKey)            //creating a filter and setting input filter
            
                //GPU Context -  We are creating
                let options = [kCIContextWorkingColorSpace : NSNull()]
                let EAGContext = EAGLContext(API: .OpenGLES2)
                let GPUContext = CIContext(EAGLContext: EAGContext, options: options)
            
            //Get the final image
            
                guard let outputImage = filter.outputImage else { fatalError("Why no image") }
                let CGImage = GPUContext.createCGImage(outputImage, fromRect: outputImage.extent)
                
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    completion(theImage: UIImage(CGImage: CGImage))
                })
            }
        }
    
    class func bw(image: UIImage, completion: FiltersCompletion) {
        self.filter("CIPhotoEffectMono", image: image, completion: completion)
    }
}


//let filterNames = CIFilter.filterNamesInCategory(kCICategoryBuiltIn) as [String]
//print(filterNames)




