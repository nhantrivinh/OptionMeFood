//
//  NewImageVC.swift
//  OptionMeFood
//
//  Created by AndAnotherOne on 6/7/16.
//  Copyright © 2016 AndAnotherOne. All rights reserved.
//

import UIKit
import Firebase

class NewImageVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        // Do any additional setup after loading the view.
        // File located on disk
//        let localFile: NSURL = ...
        // Create a reference to the file you want to upload
//        let riversRef = REF_STORAGE_IMAGES.child(<#T##path: String##String#>)
        
        // Upload the file to the path "images/rivers.jpg"
//        let uploadTask = riversRef.putFile(localFile, metadata: nil) { metadata, error in
//            if (error != nil) {
//                // Uh-oh, an error occurred!
//            } else {
//                // Metadata contains file metadata such as size, content-type, and download URL.
//                let downloadURL = metadata!.downloadURL
//            }
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func selectImage() {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .PhotoLibrary
    }
    
    func selectCamera() {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .Camera
    }

}
