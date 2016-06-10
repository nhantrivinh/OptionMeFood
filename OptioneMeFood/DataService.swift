//
//  DataService.swift
//  OptionMeFood
//
//  Created by AndAnotherOne on 6/1/16.
//  Copyright © 2016 AndAnotherOne. All rights reserved.
//

import Foundation
import Firebase

let URL_BASE = FIRDatabase.database().reference()

let STORAGE = FIRStorage.storage()
let REF_STORAGE = STORAGE.referenceForURL("gs://optionmefood-9b8fb.appspot.com")
let REF_STORAGE_IMAGES = REF_STORAGE.child("images")

class DataService {
    
    static let instance = DataService()
    
    private var _REF_BASE = URL_BASE
    private var _REF_POSTS = URL_BASE.child("posts")
    private var _REF_USERS = URL_BASE.child("users")
    
    var REF_BASE: FIRDatabaseReference {
        get {
            return _REF_BASE
        }
    }
    
    var REF_POSTS: FIRDatabaseReference {
        get {
            return _REF_POSTS
        }
    }
    
    var REF_USERS: FIRDatabaseReference {
        get {
            return _REF_USERS
        }
    }
    
    var REF_UIDS: FIRDatabaseReference {
        get {
            let uid = _REF_USERS.child("uids")
            return uid
        }
    }
    
    var REF_USERNAMES: FIRDatabaseReference {
        get {
            let usernames = _REF_USERS.child("usernames")
            return usernames
        }
    }
    
    var REF_USER_CURRENT: FIRDatabaseReference {
        get {
            let uid = NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) as! String
            let user = REF_UIDS.child(uid)
            return user
        }   
    }
    
    func createFirebaseUser(uid: String, user: Dictionary<String, String>) {
        REF_UIDS.child(uid).updateChildValues(user)
    }
    
//    func createFirebaseUsername(username: String, uid: Dictionary<String, AnyObject>) {
//        REF_USERNAMES.child(username).updateChildValues(uid)
//    }
    
    
    //Original
    func createFirebaseUsername(username: Dictionary<String, AnyObject>) {
        REF_USERNAMES.updateChildValues(username)
    }
    
    func uploadImageToFirebase(username: String, imageData: NSData!) {
        
        if imageData == nil {
            print("Choose an image")
        } else {
            
            let photosRef = REF_STORAGE_IMAGES
            let refUser = DataService.instance.REF_USERNAMES.child(username)
            print(refUser)
            //Convert username to UID
            //Getting UID
            refUser.queryOrderedByKey().observeSingleEventOfType(.Value, withBlock: { (snapshot) in
                if snapshot.value is NSNull {
                    print("image null")
                } else {
                    //Found UID
                    print("Found user's uid")
                    let uid = String(snapshot.valueForKey(username))
                    print("uid", uid)
                    let metadata = FIRStorageMetadata()
                    metadata.contentType = "image/jpeg"
                    
                    let userPhotoRef = photosRef.child(uid).child("profile_picture.jpeg")
                    let uploadTask = userPhotoRef.child(uid).putData(imageData, metadata: metadata)
                    
                    uploadTask.observeStatus(.Progress, handler: { (snapshot) in
                        // Upload reported progress
                        if let progress = snapshot.progress {
                            let percentComplete = 100 * Double(progress.completedUnitCount) / Double(progress.totalUnitCount)
                            
                            let percentInt = Int(percentComplete)
                            let percentCGFloat = CGFloat(percentComplete/100)
//                            self.imageView.alpha = percentCGFloat
                        }
                    })
                    
                    uploadTask.observeStatus(.Success) { (snapshot) in
                        // When the image has successfully uploaded, we get it's download URL
                        if let text = snapshot.metadata?.downloadURL()?.absoluteString {
                            print(text)
                            print("image uploaded")
                        }
                        
                    }
                    
                    uploadTask.observeStatus(.Failure) { (snapshot) in
                        // When the image has successfully uploaded, we get it's download URL
                        if let text = snapshot.metadata?.downloadURL()?.absoluteString {
                            print(text)
                            print("image failed to upload")
                        }
                        
                    }
                }
            })
            
            
    }
    }
    
}