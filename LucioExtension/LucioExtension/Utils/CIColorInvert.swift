//
//  CIColorInvert.swift
//  ToolKit
//
//  Created by Lucio on 16/1/4.
//  Copyright © 2016年 Person. All rights reserved.
//

import UIKit


// 颜色取反
open class CIColorInvert: CIFilter {
    
    open var inputImage = CIImage()
    
    convenience init(inputImage:CIImage) {
        self.init()
        self.inputImage = inputImage
    }
    override open var outputImage: CIImage? {
        let filter = CIFilter(name: "CIColorMatrix",
                              withInputParameters:[kCIInputImageKey:inputImage,
                                "inputRVector":CIVector(x: -1),
                                "inputGVector":CIVector(x: 0, y: -1,z: 0),
                                "inputBVector":CIVector(x:0,y:0,z: -1),
                                "inputBiasVector":CIVector(x:1,y:1,z: 1)])
        return filter?.outputImage
    }
}
