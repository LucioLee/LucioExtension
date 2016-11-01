//
//  UIColor+Extension.swift
//  LucioExtension
//
//  Created by Lucio on 16/3/10.
//  Copyright © 2016年 Person. All rights reserved.
//

import UIKit

public extension UIColor {
    
    public class var pink: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 192.0 / 255.0, blue: 203.0 / 255.0, alpha: 1)
    }

    public class func random() -> UIColor {
        let red   = CGFloat(Double(arc4random()).truncatingRemainder(dividingBy: 256.0) / 255.0)
        let green = CGFloat(Double(arc4random()).truncatingRemainder(dividingBy: 256.0) / 255.0)
        let blue  = CGFloat(Double(arc4random()).truncatingRemainder(dividingBy: 256.0) / 255.0)
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    public convenience init(hex:UInt32) {
        let red   = CGFloat((hex >> 16) & 0xFF) / 255.0
        let green = CGFloat((hex >> 08) & 0xFF) / 255.0
        let blue  = CGFloat((hex >> 00) & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
    public class func color(withHex hexColor:UInt32) -> UIColor {
        return UIColor(hex: hexColor)
    }
}
