//
//  QuartzCore+Extension.swift
//  ToolKit
//
//  Created by Lucio on 15/12/29.
//  Copyright © 2015年 Person. All rights reserved.
//

import QuartzCore

public extension CAMediaTimingFunction {
    
    @nonobjc public static let Linear        = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    @nonobjc public static let EaseIn        = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
    @nonobjc public static let Default       = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
    @nonobjc public static let EaseOut       = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
    @nonobjc public static let EaseInEaseOut = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
}
