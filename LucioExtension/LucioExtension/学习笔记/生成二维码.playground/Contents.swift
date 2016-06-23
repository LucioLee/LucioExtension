//: Playground - noun: a place where people can play

import UIKit

//生成二维码
let filter = CIFilter(name: "CIQRCodeGenerator")!
let inputContent = "http://www.baidu.com".dataUsingEncoding(NSUTF8StringEncoding)
filter.setValue(inputContent, forKey: "inputMessage")
filter.setValue("H", forKey: "inputCorrectionLevel")
var outputImage = filter.outputImage
let scale = CGAffineTransformMakeScale(10, 10)
outputImage = outputImage?.imageByApplyingTransform(scale)

//添加中心图片
let image = UIImage(CIImage: outputImage!)
UIGraphicsBeginImageContext(image.size)
image.drawInRect(CGRect(x: 0, y: 0, width: image.size.height, height: image.size.width))
[#Image(imageLiteral: "bg.jpg")#].drawInRect(CGRect(x: (image.size.width - 80) * 0.5, y: (image.size.height - 80) * 0.5, width: 80, height: 80))
let finallImage = UIGraphicsGetImageFromCurrentImageContext()
UIGraphicsEndImageContext()

//识别二维码
let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: nil)
let imageCI = CIImage(image: finallImage)!
let features = detector.featuresInImage(imageCI) as! [CIQRCodeFeature]
var strMsg = ""
features.forEach({strMsg = strMsg + $0.messageString})
strMsg





