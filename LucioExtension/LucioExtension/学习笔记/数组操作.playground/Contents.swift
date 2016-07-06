//: Playground - noun: a place where people can play

import UIKit

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
    
    public subscript(index1: Int,index2 : Int,restIndexs : Int...) -> [Element] {
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

let array = [1,2,3,4,5,6,7,8,9]
let containThree = array.some({$0 == 3})
let allGreaterThanThree = array.some({$0 > 3})
let values = array[1,3,5,7]

