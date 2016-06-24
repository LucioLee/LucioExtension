import UIKit



enum UIImageRotateOrientation : Int {
    case Left // 90 deg CCW
    case Right // 90 deg CW
    case Down // 180 deg rotation
    case Mirrored // as above but image mirrored along other axis. horizontal flip
    case DownMirrored // horizontal flip
    case LeftMirrored // vertical flip
    case RightMirrored // vertical flip
}
extension UIImage {
    func rotate(orientation: UIImageRotateOrientation) -> UIImage {
        var transform = CGAffineTransformIdentity
        switch orientation {
        case .Mirrored :
            transform = CGAffineTransformTranslate(transform, size.width,0)
            transform = CGAffineTransformScale(transform, -1, 1)
        case .Left :
            transform = CGAffineTransformTranslate(transform, size.height,0)
            transform = CGAffineTransformRotate(transform, CGFloat(M_PI_2))
        case .LeftMirrored :
            transform = CGAffineTransformRotate(transform, CGFloat(M_PI_2))
            transform = CGAffineTransformTranslate(transform, size.width ,-image.size.height)
            transform = CGAffineTransformScale(transform, -1, 1)
        case .Down :
            transform = CGAffineTransformTranslate(transform, size.width,image.size.height)
            transform = CGAffineTransformRotate(transform, CGFloat(M_PI))
        case .DownMirrored :
            transform = CGAffineTransformTranslate(transform, 0,size.height)
            transform = CGAffineTransformScale(transform, 1, -1)
        case .Right :
            transform = CGAffineTransformTranslate(transform, 0,size.width)
            transform = CGAffineTransformRotate(transform, -CGFloat(M_PI_2))
        case .RightMirrored :
            transform = CGAffineTransformRotate(transform, CGFloat(M_PI_2))
            transform = CGAffineTransformScale(transform, 1, -1)
        }
        let drawSize = [.Left, .LeftMirrored, .Right, .RightMirrored].contains(orientation) ? CGSize(width: size.height, height: size.width) : CGSize(width: size.width, height: size.height)
        
        let context = CGBitmapContextCreate(nil, Int(drawSize.width), Int(drawSize.height), CGImageGetBitsPerComponent(CGImage),0, CGImageGetColorSpace(CGImage), CGImageGetBitmapInfo(CGImage).rawValue)
        CGContextConcatCTM(context, transform)
        CGContextDrawImage(context, CGRect(x: 0, y: 0, width:size.width, height: size.height),CGImage)
        let cgImg = CGBitmapContextCreateImage(context)!
        let img =  UIImage(CGImage: cgImg, scale: scale, orientation: imageOrientation)
        return img
    }
}
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

