//
//  NewImageVC.swift
//  OptionMeFood
//
//  Created by AndAnotherOne on 6/7/16.
//  Copyright © 2016 AndAnotherOne. All rights reserved.
//

import UIKit
import Firebase
import ALCameraViewController

class NewImageVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var btnUpload: UIButton!
    
    @IBOutlet weak var imageView: DesignableImageView!
    
    let croppingEnabled = true
    
    var imageData: NSData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneBtnDidTouch(sender: AnyObject) {
        if self.imageData == nil {
            print("Choose an image")
        } else {
            
            let photosRef = REF_STORAGE_IMAGES
            
            let username = "test"

            let refUser = DataService.instance.REF_USERNAMES.child(username)
            refUser.queryOrderedByKey().observeSingleEventOfType(.Value, withBlock: { (snapshot) in
                if snapshot.value is NSNull {
                    print("image null")
                } else {
                    print("found user's image storage location")
                }
            })
            print(refUser)
            
            

            
//            let userPhotoRef = photosRef.child(uid).child("profile_picture.jpeg")
            
            
//            let photoRef = photosRef.child("\(uid)\(NSUUID().UUIDString).jpeg")
            
            // Upload file to Firebase Storage
//            let metadata = FIRStorageMetadata()
//            metadata.contentType = "image/jpeg"
//            
//            let uploadTask = userPhotoRef.child(key).(uid).putData(imageData, metadata: metadata)
//            
//            uploadTask.observeStatus(.Progress, handler: { (snapshot) in
//                // Upload reported progress
//                if let progress = snapshot.progress {
//                    let percentComplete = 100 * Double(progress.completedUnitCount) / Double(progress.totalUnitCount)
//                    
//                    let percentInt = Int(percentComplete)
//                    let percentCGFloat = CGFloat(percentComplete/100)
//                    self.imageView.alpha = percentCGFloat
//                }
//            })
//            
//            uploadTask.observeStatus(.Success) { (snapshot) in
//                // When the image has successfully uploaded, we get it's download URL
//                if let text = snapshot.metadata?.downloadURL()?.absoluteString {
//                    print(text)
//                    print("image uploaded")
//                }
//                
//            }
//            
//            uploadTask.observeStatus(.Failure) { (snapshot) in
//                // When the image has successfully uploaded, we get it's download URL
//                if let text = snapshot.metadata?.downloadURL()?.absoluteString {
//                    print(text)
//                    print("image failed to upload")
//                }
//                
//            }
            
        }
        

    }
    
    @IBAction func btnUploadDidTouch(sender: AnyObject) {
        let libraryViewController = CameraViewController.imagePickerViewController(croppingEnabled) { image, asset in
            if image != nil {
                self.imageView.image = image
                self.imageData = UIImageJPEGRepresentation(image!, 1)
            } else {
                print("No image")
            }
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        presentViewController(libraryViewController, animated: true, completion: nil)
        
    }

}
