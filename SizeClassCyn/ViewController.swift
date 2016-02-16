//
//  ViewController.swift
//  SizeClassCyn
//
//  Created by Cynthia Whitlatch on 2/16/16.
//  Copyright © 2016 Cynthia Whitlatch. All rights reserved.
//

import UIKit
import CloudKit


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    
    
    @IBAction func addImagePressed(sender: UIBarButtonItem) {

    let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func saveImagePressed(sender: UIBarButtonItem)
    {
        
        guard let image = self.imageView.image else { return }
        UIImageWriteToSavedPhotosAlbum(image, self, "image: didFinishSavingWithError:contextInto:", nil)
        
        
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafePointer<Void>)
    {
        if error != nil {
            
            let alertView = UIAlertController(title: "Saved", message: "Your image has been save to your photos", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            
            alertView.addAction(okAction)
                
            self.presentViewController(alertView, animated: true, completion: nil)
        }
    }
    
    @IBAction func editButtonPressed(sender: UIBarButtonItem) {
        
        guard let image = self.imageView.image else { return }
        
        let actionSheet = UIAlertController(title: "Filters", message: "Please Select a Filter" as String, preferredStyle:.Alert)
        let bwAction = UIAlertAction(title: "Black & White", style: .Default) { (action) -> Void in
            filters.bw(image, completion: { (theImage) -> () in
                self.imageView.image = theImage })
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            actionSheet.addAction(bwAction)
            actionSheet.addAction(cancelAction)
            
        self.presentViewController(actionSheet, animated: true, completion: nil)
        
        
    }
            //Mark:   IMAGE PICKER CONTROLLER ************************
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
     
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .ScaleAspectFill
            imageView.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Find out when the app is becoming active and inactive
        so that we can find out when the user's iCloud logging status changes.*/
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "applicationBecameActive:",
            name: UIApplicationDidBecomeActiveNotification,
            object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "applicationBecameInactive:",
            name: UIApplicationWillResignActiveNotification,
            object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        container.accountStatusWithCompletionHandler {
            (status: CKAccountStatus, error: NSError?) in
            
            /* Be careful, we might be on a different thread now so make sure that
            your UI operations go on the main thread */
            NSOperationQueue().addOperationWithBlock  ({ () -> Void in
                
                var title: String!
                var message: String!
                
                if error != nil{
                    title = "Error"
                    message = "An error occurred = \(error)"
                } else {
                    
                    title = "No errors occurred"
                    
                    switch status{
                    case .Available:
                        message = "The user is logged in to iCloud"
                    case .CouldNotDetermine:
                        message = "Could not determine if the user is logged" +
                        " into iCloud or not"
                    case .NoAccount:
                        message = "User is not logged into iCloud"
                    case .Restricted:
                        message = "Could not access user's iCloud account information"
                    }
                    
                    self.displayAlertWithTitle(title, message: message)
                }
                
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in

                })
                
            })
            
        }
        
    }
    
    /* Just a little method to help us display alert dialogs to the user */
    func displayAlertWithTitle(title: String, message: String){
        let controller = UIAlertController(title: title,
            message: message,
            preferredStyle: .Alert)
        
        controller.addAction(UIAlertAction(title: "OK",
            style: .Default,
            handler: nil))
        
        presentViewController(controller, animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}



