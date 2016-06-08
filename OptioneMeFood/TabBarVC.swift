//
//  TabBarVC.swift
//  OptionMeFood
//
//  Created by AndAnotherOne on 6/3/16.
//  Copyright © 2016 AndAnotherOne. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let topBorder = CALayer()
        topBorder.frame = CGRectMake(0, 0, 1000, 0.5)
        topBorder.backgroundColor = UIColor(red: 229, green: 231, blue: 235, alpha: 1.0).CGColor
        
        tabBar.layer.addSublayer(topBorder)
        tabBar.clipsToBounds = true
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
