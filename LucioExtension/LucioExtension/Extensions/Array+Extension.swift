//
//  Array+Extension.swift
//  LucioExtension
//
//  Created by Lucio on 16/3/10.
//  Copyright © 2016年 Person. All rights reserved.
//

import Foundation

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