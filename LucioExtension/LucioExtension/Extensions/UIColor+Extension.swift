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

    public class var random: UIColor {
        let red   = CGFloat(Double(arc4random()).truncatingRemainder(dividingBy: 256.0) / 255.0)
        let green = CGFloat(Double(arc4random()).truncatingRemainder(dividingBy: 256.0) / 255.0)
        let blue  = CGFloat(Double(arc4random()).truncatingRemainder(dividingBy: 256.0) / 255.0)
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    public convenience init?(hexLiteral: UInt32) {
        if hexLiteral > 0xFFFFFF { return nil}
        let red   = CGFloat((hexLiteral >> 16) & 0xFF) / 255.0
        let green = CGFloat((hexLiteral >> 08) & 0xFF) / 255.0
        let blue  = CGFloat((hexLiteral >> 00) & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
    public class func color(withHexLiteral hexColor: UInt32) -> UIColor? {
        return UIColor(hexLiteral: hexColor)
    }
    
}
