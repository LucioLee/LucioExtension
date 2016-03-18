//
//  Array+Extension.swift
//  LucioExtension
//
//  Created by Lucio on 16/3/10.
//  Copyright © 2016年 Person. All rights reserved.
//

import Foundation

public extension SequenceType {
    @warn_unused_result
    public func some(@noescape includeElement:(Self.Generator.Element) throws -> Bool) rethrows -> Bool {
    
        for element in self {
            do {
                if try includeElement(element) == true {return true}
            } catch {
                return try includeElement(element)
            }
        }
        return false;
    }
    
    @warn_unused_result
    public func every(@noescape includeElement:(Self.Generator.Element) throws -> Bool) rethrows -> Bool {
        
        for element in self {
            do {
                if try includeElement(element) == false {return false}
            } catch {
                return try includeElement(element)
            }
        }
        return true;
    }
}


public extension Array {
    
    public subscript(index1 : Int,index2 : Int,restIndexs : Int...) -> [Element] {
        get {
            var results : [Element] = [self[index1],self[index2]]
            for index in restIndexs {
                results.append(self[index])
            }
            return results
        }
        set {
            for (index,value) in zip([index1,index2]+restIndexs, newValue) {
                self[index] = value
            }
        }
    }
}