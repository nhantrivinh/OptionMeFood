//
//  IntroVC.swift
//  OptionMeFood
//
//  Created by AndAnotherOne on 5/31/16.
//  Copyright © 2016 JVinciCode. All rights reserved.
//

import UIKit

import Firebase
import FirebaseAuth

import FBSDKCoreKit
import FBSDKLoginKit

class IntroVC: UIViewController {

    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var lblLogin: UILabel!
    @IBOutlet weak var lblOr: UILabel!
    @IBOutlet weak var btnFb: MaterialBtn!
    @IBOutlet weak var btnGg: MaterialBtn!
    
    @IBOutlet weak var viewBtnFb: UIView!
    @IBOutlet weak var viewBtnGg: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Uncomment to automatically sign in the user.
        //GIDSignIn.sharedInstance().signInSilently()
        
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
        animateViewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        //If the user is already logged in take them straight to the next screen
        if NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) != nil {
            self.performSegueWithIdentifier(IntroVCToHomeVC, sender: nil)
        }
    }

    @IBAction func btnPressedFbLogin(sender: AnyObject) {
  
        let fbLogin = FBSDKLoginManager()
        fbLogin.logInWithReadPermissions(["email"]) { (facebookResult: FBSDKLoginManagerLoginResult!, facebookError: NSError!) in
            
            if facebookError != nil {
                print("FB login failed. Error \(facebookError.debugDescription)")
            } else if facebookResult.isCancelled {
                print("Facebook Login is cancelled")
            } else {
                    let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                    print("Successfully logged in with FB \(accessToken)")

                    let credential = FIRFacebookAuthProvider.credentialWithAccessToken(accessToken)
                    
                    FIRAuth.auth()?.signInWithCredential(credential, completion: { (user, error) in
                        if error != nil {
                            print("Login failed. \(error)")
                            
                        } else {
                            print("Logged in. \(user)")
                            let userData = ["provider": credential.provider]
                            DataService.ds.createFirebaseUser(user!.uid, user: userData)
                            
                            NSUserDefaults.standardUserDefaults().setValue(user!.uid, forKey: KEY_UID)
                            self.performSegueWithIdentifier(IntroVCToHomeVC, sender: nil)

                        }
                    })
            }
        }
    }
    
    @IBAction func btnPressedGgLogin(sender: AnyObject) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    //Blahblah
    func animateViewDidLoad() {
        let OPAQUE: CGFloat = 1.0
        let TRANSPARENT: CGFloat = 0.0
        
        let fullFrame = self.view.frame.width * 2
        print(fullFrame)
        let radiusFrame = (114 - fullFrame)/2
        logo.frame = CGRectMake(radiusFrame, radiusFrame, fullFrame, fullFrame)
        logo.alpha = 0.6
        
        lblLogin.alpha = TRANSPARENT
        lblOr.alpha = TRANSPARENT
        btnFb.alpha = TRANSPARENT
        btnGg.alpha = TRANSPARENT
        UIView.animateWithDuration(0.3, animations: {
            
            self.logo.frame = CGRectMake(0, 0, 114, 114)
            self.logo.alpha = OPAQUE
            
            self.lblLogin.alpha = OPAQUE
            self.lblOr.alpha = OPAQUE
            self.btnFb.alpha = OPAQUE
            self.btnGg.alpha = OPAQUE
            }, completion: nil)
    }
    
    

}

extension IntroVC: GIDSignInDelegate {
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
                withError error: NSError!) {
        if let error = error {
            print("\(error)")
            return
        } else {
            let authentication = user.authentication
            let credential = FIRGoogleAuthProvider.credentialWithIDToken(authentication.idToken, accessToken: authentication.accessToken)
            FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
                if error != nil {
                    print("Something went wrong")
                } else {
                    //User logged in...do something
                    print("Logged in. \(user)")
                    let userData = ["provider": credential.provider]
                    DataService.ds.createFirebaseUser(user!.uid, user: userData)
                    
                    NSUserDefaults.standardUserDefaults().setValue(user!.uid, forKey: KEY_UID)
                    print(user!.uid)
                    self.performSegueWithIdentifier(IntroVCToHomeVC, sender: nil)
                }
            }
        }
    }
    
}

extension IntroVC: GIDSignInUIDelegate {
    
}

