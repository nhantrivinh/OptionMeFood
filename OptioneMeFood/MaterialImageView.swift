//
//  MaterialImage.swift
//  OptionMeFood
//
//  Created by AndAnotherOne on 6/9/16.
//  Copyright © 2016 AndAnotherOne. All rights reserved.
//

import UIKit

class MaterialImageView: UIImageView {

    override func awakeFromNib() {
        layer.borderColor = UIColor.blackColor().CGColor
        layer.cornerRadius = layer.frame.size.width/2
        layer.borderWidth = 1.5
        layer.masksToBounds = true
    }

}
