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
        
        if charCount == 0 {
            lblReport.text = "enter a username"
            print("char count 0")
        } else if charCount > limitLength {
            print("char count > \(limitLength)")
        } else {
            lblReport.text = "Checking..."
            print("Validation Time")
            
            let refUser = DataService.instance.REF_USERNAMES.child(usernameInput)
            print(refUser)

            refUser.queryOrderedByKey().observeEventType(.Value, withBlock: { snapshot in
                print("This is the snapshot",snapshot)
                
                if snapshot.value is NSNull {
                    print("username created")
                    self.lblReport.text = ""
                    
                    let uid = 0123456789
                    let appUsername: Dictionary<String, AnyObject> = [usernameInput: uid]
                    DataService.instance.createFirebaseUsername(appUsername)
                    
                    self.performSegueWithIdentifier(Constants.Segues.SignUpToSignUpImage, sender: nil)
                    
                } else {
                    print(self.usernameRepeats)
                    print("username already existed")
                    self.lblReport.text = "Username already exists"
                }

                
            })

            
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        self.view.endEditing(true)
    }
    
    //Textfield
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        lblReport.text = ""
        let charactersCount = tfUsername.text?.characters.count
        if range.length + range.location > charactersCount {
            return false
        }
        
        let newLength = charactersCount! + string.characters.count - range.length
        return newLength <= limitLength
        
    }
    
}
