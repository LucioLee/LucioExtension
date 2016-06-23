import UIKit

//原图
let image = [#Image(imageLiteral: "image.jpg")#]

//镜像
var transform = CGAffineTransformIdentity
transform = CGAffineTransformTranslate(transform, image.size.width,0)
transform = CGAffineTransformScale(transform, -1, 1)
var context = CGBitmapContextCreate(nil, Int(image.size.width), Int(image.size.height), CGImageGetBitsPerComponent(image.CGImage),0, CGImageGetColorSpace(image.CGImage), CGImageGetBitmapInfo(image.CGImage).rawValue)
CGContextConcatCTM(context, transform)
CGContextDrawImage(context, CGRect(x: 0, y: 0, width:image.size.width, height: image.size.height),image.CGImage)
var cgImg = CGBitmapContextCreateImage(context)!
var img =  UIImage(CGImage: cgImg, scale: image.scale, orientation: image.imageOrientation)

//左转90度
transform = CGAffineTransformIdentity
transform = CGAffineTransformTranslate(transform, image.size.height,0)
transform = CGAffineTransformRotate(transform, CGFloat(M_PI_2))
context = CGBitmapContextCreate(nil, Int(image.size.height), Int(image.size.width), CGImageGetBitsPerComponent(image.CGImage),0, CGImageGetColorSpace(image.CGImage), CGImageGetBitmapInfo(image.CGImage).rawValue)
CGContextConcatCTM(context, transform)
CGContextDrawImage(context, CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height),image.CGImage)
cgImg = CGBitmapContextCreateImage(context)!
img =  UIImage(CGImage: cgImg, scale: image.scale, orientation: image.imageOrientation)

//左转90度 + 镜像
transform = CGAffineTransformIdentity
transform = CGAffineTransformRotate(transform, CGFloat(M_PI_2))
transform = CGAffineTransformTranslate(transform, image.size.width ,-image.size.height)
transform = CGAffineTransformScale(transform, -1, 1)
context = CGBitmapContextCreate(nil, Int(image.size.height), Int(image.size.width), CGImageGetBitsPerComponent(image.CGImage),0, CGImageGetColorSpace(image.CGImage), CGImageGetBitmapInfo(image.CGImage).rawValue)
CGContextConcatCTM(context, transform)
CGContextDrawImage(context, CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height),image.CGImage)
cgImg = CGBitmapContextCreateImage(context)!
img =  UIImage(CGImage: cgImg, scale: image.scale, orientation: image.imageOrientation)

//倒转
transform = CGAffineTransformIdentity
transform = CGAffineTransformTranslate(transform, image.size.width,image.size.height)
transform = CGAffineTransformRotate(transform, CGFloat(M_PI))
context = CGBitmapContextCreate(nil, Int(image.size.width), Int(image.size.height), CGImageGetBitsPerComponent(image.CGImage),0, CGImageGetColorSpace(image.CGImage), CGImageGetBitmapInfo(image.CGImage).rawValue)
CGContextConcatCTM(context, transform)
CGContextDrawImage(context, CGRect(x: 0, y: 0, width:image.size.width, height: image.size.height),image.CGImage)
cgImg = CGBitmapContextCreateImage(context)!
img =  UIImage(CGImage: cgImg, scale: image.scale, orientation: image.imageOrientation)

//倒转 + 镜像
transform = CGAffineTransformIdentity
transform = CGAffineTransformTranslate(transform, 0,image.size.height)
transform = CGAffineTransformScale(transform, 1, -1)
context = CGBitmapContextCreate(nil, Int(image.size.width), Int(image.size.height), CGImageGetBitsPerComponent(image.CGImage),0, CGImageGetColorSpace(image.CGImage), CGImageGetBitmapInfo(image.CGImage).rawValue)
CGContextConcatCTM(context, transform)
CGContextDrawImage(context, CGRect(x: 0, y: 0, width:image.size.width, height: image.size.height),image.CGImage)
cgImg = CGBitmapContextCreateImage(context)!
img =  UIImage(CGImage: cgImg, scale: image.scale, orientation: image.imageOrientation)

//右转90度
transform = CGAffineTransformIdentity
transform = CGAffineTransformTranslate(transform, 0,image.size.width)
transform = CGAffineTransformRotate(transform, -CGFloat(M_PI_2))
context = CGBitmapContextCreate(nil, Int(image.size.height), Int(image.size.width), CGImageGetBitsPerComponent(image.CGImage),0, CGImageGetColorSpace(image.CGImage), CGImageGetBitmapInfo(image.CGImage).rawValue)
CGContextConcatCTM(context, transform)
CGContextDrawImage(context, CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height),image.CGImage)
cgImg = CGBitmapContextCreateImage(context)!
img =  UIImage(CGImage: cgImg, scale: image.scale, orientation: image.imageOrientation)

//右转90度 + 镜像
transform = CGAffineTransformIdentity
transform = CGAffineTransformRotate(transform, CGFloat(M_PI_2))
transform = CGAffineTransformScale(transform, 1, -1)
context = CGBitmapContextCreate(nil, Int(image.size.height), Int(image.size.width), CGImageGetBitsPerComponent(image.CGImage),0, CGImageGetColorSpace(image.CGImage), CGImageGetBitmapInfo(image.CGImage).rawValue)
CGContextConcatCTM(context, transform)
CGContextDrawImage(context, CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height),image.CGImage)
cgImg = CGBitmapContextCreateImage(context)!
img =  UIImage(CGImage: cgImg, scale: image.scale, orientation: image.imageOrientation)

