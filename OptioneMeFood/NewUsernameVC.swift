//
//  SignUpVC.swift
//  OptionMeFood
//
//  Created by AndAnotherOne on 6/3/16.
//  Copyright © 2016 AndAnotherOne. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    
    @IBOutlet weak var tfUsername: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        let offset = 0.3
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(offset * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { 
            self.tfUsername.becomeFirstResponder()
        }
    }

    @IBAction func didTapNextBtn(sender: AnyObject) {
        if let username = tfUsername.text where username != "" {
            print("Valid Username")
        } else {
            print("Invalid Username")
        }
    }

}
