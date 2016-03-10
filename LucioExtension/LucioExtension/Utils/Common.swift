//
//  Common.swift
//  LucioExtension
//
//  Created by Lucio on 16/3/10.
//  Copyright © 2016年 Person. All rights reserved.
//

import Foundation

public func printLog<T>(message: T, file: String = __FILE__, method: String = __FUNCTION__, line: Int = __LINE__) {
    #if DEBUG
        print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
    #endif
}