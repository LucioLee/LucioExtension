//
//  Array+Extension.swift
//  LucioExtension
//
//  Created by Lucio on 16/3/10.
//  Copyright © 2016年 Person. All rights reserved.
//

import Foundation

public extension Equatable {
    
    public func isIn<T: Sequence>(_ collection: T) -> Bool where T.Iterator.Element == Self {
        return collection.contains(self)
    }
    public func isIn(_ collection: Self...) -> Bool {
        return collection.contains(self)
    }
}

public extension Sequence {
    
    public func some(_ includeElement: (Self.Iterator.Element) throws -> Bool) rethrows -> Bool {
    
        for element in self {
            do {
                if try includeElement(element) == true {return true}
            } catch {
                return try includeElement(element)
            }
        }
        return false;
    }
    
    public func every(_ includeElement:(Self.Iterator.Element) throws -> Bool) rethrows -> Bool {
        
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
