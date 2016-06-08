//
//  SignUpVC.swift
//  OptionMeFood
//
//  Created by AndAnotherOne on 6/3/16.
//  Copyright © 2016 AndAnotherOne. All rights reserved.
//

import UIKit
import Firebase

class NewUsernameVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var lblReport: UILabel!
    @IBOutlet weak var tfUsername: UITextField!
    
    let limitLength = 12
    var usernameRepeats: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfUsername.delegate = self
        lblReport.text = ""

    }
    
    override func viewDidAppear(animated: Bool) {
        let offset = 0.3
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(offset * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { 
            self.tfUsername.becomeFirstResponder()
        }
    }

    @IBAction func didTapNextBtn(sender: AnyObject) {
        
        usernameRepeats = false
        let charCount = tfUsername.text!.characters.count
        let usernameInput = tfUsername.text!
        var times = 0
        if charCount == 0 {
            lblReport.text = "enter a username"
            print("char count 0")
        } else if charCount > limitLength {
            print("char count > \(limitLength)")
        } else {
            lblReport.text = "Checking..."
            print("Validation Time")
            

            let usernameRepeats = DataService.instance.REF_USERNAMES.queryOrderedByKey().isEqual(usernameInput)
            print(usernameRepeats)
            
//            if self.usernameRepeats == false {
//                print("username created")
//                self.lblReport.text = ""
//                let uid: Dictionary<String, AnyObject> = ["uid": 0123456789]
//                let appUsername: String = usernameInput
//                DataService.instance.createFirebaseUsername(appUsername, uid: uid)
//                self.performSegueWithIdentifier(Constants.Segues.SignUpToSignUpImage, sender: nil)
//            } else {
//                print("username already existed")
//                self.lblReport.text = "Username already exists"
//            }
            
            
            
//            DataService.instance.REF_USERNAMES.observeSingleEventOfType(.Value, withBlock: { (snapshot) in
//
//                if let snaps = snapshot.children.allObjects as? [FIRDataSnapshot] {
//                    for snap in snaps {
//                        while self.usernameRepeats == false {
//                            if snap.value != nil {
//                                times = times + 1
//                                let usernameCheck = snap.key
//                                print(usernameCheck)
//                                if usernameCheck == usernameInput {
//                                    self.usernameRepeats = true
//                                }
//                            }
//                        }
//                    }
//
//                    if self.usernameRepeats == false {
//                        self.lblReport.text = ""
//                        print("username created")
//                        let uid = 0123456789
//                        let appUsername: Dictionary<String, AnyObject> = [usernameInput: uid]
//                        DataService.instance.createFirebaseUsername(appUsername)
//                        self.performSegueWithIdentifier(Constants.Segues.SignUpToSignUpImage, sender: nil)
//                    } else {
//                        print("username already existed")
//                        self.lblReport.text = "Username already exists"
//                    }
//                    print(times)
//                }
                
                
//                if let snaps = [2] {
//                    for snap in snaps {
//                        while self.usernameRepeats == false {
//                            if snap.value != nil {
//    
//                                let usernameCheck = snap.key
//                                if usernameCheck == usernameInput {
//                                    self.usernameRepeats = true
//                                }
//                            }
//                        }
//                    }
//                }
                
                
                
                
//            })
        }
    }
    
    //Textfield
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        lblReport.text = ""
        let charactersCount = tfUsername.text?.characters.count
        print(charactersCount)
        print(range.length)
        print(range.location)
        if range.length + range.location > charactersCount {
            return false
        }
        
        let newLength = charactersCount! + string.characters.count - range.length
        print(newLength)
        return newLength <= limitLength
        
    }
    
}
