//
//  UIBarButtonItem+Extension.swift
//  LucioExtension
//
//  Created by 李新新 on 16/4/13.
//  Copyright © 2016年 Person. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    class func item(imageNamed: String,highlightImageNamed: String?,target: AnyObject?,action: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .Custom)
        button.setBackgroundImage(UIImage(named: imageNamed), forState: .Normal)
        if highlightImageNamed != nil {
            button.setBackgroundImage(UIImage(named: imageNamed), forState: .Highlighted)
        }
        button.size = button.currentBackgroundImage!.size
        
        button.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        return UIBarButtonItem(customView: button)
    }
}