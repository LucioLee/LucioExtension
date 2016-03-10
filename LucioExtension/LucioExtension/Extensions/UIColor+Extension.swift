//
//  UIColor+Extension.swift
//  LucioExtension
//
//  Created by Lucio on 16/3/10.
//  Copyright © 2016年 Person. All rights reserved.
//

import UIKit

public extension UIColor {
    
    public class func pinkColor() -> UIColor {
        return UIColor(red: 255.0/255.0, green: 192.0/255.0, blue: 203.0/255.0, alpha: 1)
    }
    
    public class func randomColor() -> UIColor {
        let red = CGFloat(Double((arc4random() % 256))/255)
        let green = CGFloat(Double((arc4random() % 256))/255)
        let blue = CGFloat(Double((arc4random() % 256))/255)
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    public class func colorWithRGBHex(hex:UInt32) -> UIColor {
        let red = CGFloat((hex >> 16) & 0xFF) / 255
        let green = CGFloat((hex >> 8) & 0xFF) / 255
        let blue = CGFloat(hex & 0xFF) / 255
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}