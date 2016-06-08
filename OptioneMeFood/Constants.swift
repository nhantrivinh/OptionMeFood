//
//  Constants.swift
//  OptionMeFood
//
//  Created by Design+Code on 5/31/16.
//  Copyright © 2016 JVinciCode. All rights reserved.
//

import Foundation
import UIKit

let KEY_UID = "uid"
let KEY_DISPLAYNAME = "display_name"

//Firebase Error Codes
let ACCOUNT_EXISTS = 17007
let ACCOUNT_WRONG_PWD = 17009
let ACCOUNT_NON_EXIST = 17011
let ACCOUNT_INVALID_EMAIL = 17999
let ACCOUNT_DISABLED = 17005
let ACCOUNT_WEAK_PWD = 17026

//Colors
let OPAQUE: CGFloat = 1.0
let TRANSPARENT: CGFloat = 0.0

struct Constants {
    struct Segues {
        static let IntroToHome = "IntroVCToHomeVC"
        static let IntroToSignUp = "IntroVCToNewUsernameVC"
        static let SignUpToSignUpImage = "NewUsernameVCToNewImageVC"
    }
}