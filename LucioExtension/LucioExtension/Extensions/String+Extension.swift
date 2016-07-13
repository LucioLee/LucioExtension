//
//  NSString+Extension.swift
//  LucioExtension
//
//  Created by 李新新 on 16/4/13.
//  Copyright © 2016年 Person. All rights reserved.
//

import Foundation

public extension String {
    
    public var trim: String {
        return stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
    
    public var isPureInt: Bool {
        let scanner = NSScanner(string: self)
        var value: Int32 = 0 //从下标0开始，扫描到的数字，碰到非数字就停止。比如 string = "12ss",则value = 12
        return scanner.scanInt(&value) && scanner.atEnd
    }
    
    public var lowercaseFirstCharacterString: String {
        let range = startIndex..<startIndex.advancedBy(1)
        let firstChar = substringToIndex(startIndex.advancedBy(1)).lowercaseString
        return stringByReplacingCharactersInRange(range, withString: firstChar)
    }
    
    public var uppercaseFirstCharacterString: String {
        let range = startIndex..<startIndex.advancedBy(1)
        let firstChar = substringToIndex(startIndex.advancedBy(1)).uppercaseString
        return stringByReplacingCharactersInRange(range, withString: firstChar)
    }
    
    public var md5: String {
        let cStr = cStringUsingEncoding(NSUTF8StringEncoding)
        let cStrLen = CC_LONG(lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
        CC_MD5(cStr!,cStrLen,result)
        var hashString = ""
        0.stride(to: digestLen, by: 1).forEach{ hashString += String(format: "%0X", result[$0]) }
        result.destroy()
        return hashString
    }
    public func appendPathComponent(string: String) -> String {
        if string.isEmpty {return self}
        return self + "/" + string
    }
    public func deleteLastPathComponent() -> String {
        return (self as NSString).stringByDeletingLastPathComponent
    }
}

public extension NSString {
    
    public func trim() -> NSString {
        return (self as String).trim
    }
    
    public func isEmpty() -> Bool {
        return (self as String).isEmpty
    }
    
    public func isPureInt() -> Bool {
        return (self as String).isPureInt
    }
    
    public func lowercaseFirstCharacterString() -> NSString {
        return (self as String).lowercaseFirstCharacterString
    }
    
    public func uppercaseFirstCharacterString() -> NSString {
        return (self as String).uppercaseFirstCharacterString
    }
    
    public func md5() -> String {
        return (self as String).md5
    }
}
