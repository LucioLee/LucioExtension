//
//  UIImage+Extension.swift
//  Daiqian
//
//  Created by 李新新 on 16/5/10.
//  Copyright © 2016年 Hangzhou Suidifu Network Technology Co., Ltd. All rights reserved.
//

import UIKit

public enum UIImageRotateOrientation : Int {
    case Left // 90 deg CCW
    case Right // 90 deg CW
    case Down // 180 deg rotation
    case Mirrored // as above but image mirrored along other axis. horizontal flip
    case DownMirrored // horizontal flip
    case LeftMirrored // vertical flip
    case RightMirrored // vertical flip
}

public extension UIImage {
    
    public var height: CGFloat {
        return size.height
    }
    public var width: CGFloat {
        return size.width
    }
    
    public func circle(withBorderWidth width: CGFloat = 0, borderColor: UIColor = UIColor.blackColor()) -> UIImage {
        
        let diameter = min(size.width, size.height)
        precondition(width <= diameter / 2.0, "Border width is too large !")
        
        let originX = (diameter - size.width) / 2.0
        let originY = (diameter - size.height) / 2.0
        let newSize = CGSize(width: diameter, height: diameter)
        UIGraphicsBeginImageContextWithOptions(newSize, false, scale)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetStrokeColorWithColor(context, borderColor.CGColor)
        CGContextSetLineWidth(context, width)
        let rect = CGRect(origin: CGPoint.zero, size: newSize)
        CGContextAddEllipseInRect(context, rect)
        CGContextClip(context)
        self.drawInRect(CGRect(origin: CGPoint(x: originX, y: originY), size: size))
        let offset = round(width / 2.0)
        CGContextAddEllipseInRect(context, CGRectInset(rect, offset, offset))
        CGContextStrokePath(context)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    public class func image(with color: UIColor) -> UIImage {
        return image(with: color, and: CGSize(width: 1, height: 1))
    }

    public class func image(with color:UIColor,and size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context,color.CGColor)
        CGContextFillRect(context, CGRect(origin: CGPoint.zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    public func fixOrientation() -> UIImage {
        
        if imageOrientation == .Up { return self }
        
        var transform: CGAffineTransform = CGAffineTransformIdentity
        
        switch imageOrientation {
        case .Left :
            transform = CGAffineTransformTranslate(transform, size.width, 0)
            transform = CGAffineTransformRotate(transform, CGFloat(M_PI_2))
        case .Down :
            transform = CGAffineTransformTranslate(transform, size.width, size.height)
            transform = CGAffineTransformRotate(transform, CGFloat(M_PI))
        case .Right:
            transform = CGAffineTransformTranslate(transform, 0, size.height)
            transform = CGAffineTransformRotate(transform, CGFloat(-M_PI_2))
        case .UpMirrored :
            transform = CGAffineTransformTranslate(transform, size.width,0)
            transform = CGAffineTransformScale(transform, -1, 1)
        case .LeftMirrored:
            transform = CGAffineTransformRotate(transform, CGFloat(M_PI_2))
            transform = CGAffineTransformTranslate(transform, size.height ,-size.width)
            transform = CGAffineTransformScale(transform, -1, 1)
        case .DownMirrored:
            transform = CGAffineTransformTranslate(transform, 0,size.height)
            transform = CGAffineTransformScale(transform, 1, -1)
        case .RightMirrored:
            transform = CGAffineTransformRotate(transform, CGFloat(M_PI_2))
            transform = CGAffineTransformScale(transform, 1, -1)
        default:
            break
        }
        let drawSize = [.Left, .LeftMirrored, .Right, .RightMirrored].contains(imageOrientation) ? CGSize(width: size.height, height: size.width) : CGSize(width: size.width, height: size.height)
        let context = CGBitmapContextCreate(nil, Int(size.width), Int(size.height), CGImageGetBitsPerComponent(CGImage), 0, CGImageGetColorSpace(CGImage), CGImageGetBitmapInfo(CGImage).rawValue)!
        CGContextConcatCTM(context, transform)
        CGContextDrawImage(context, CGRect(origin: CGPoint.zero, size:drawSize), CGImage)
        let cgImg = CGBitmapContextCreateImage(context)!
        let img:UIImage = UIImage(CGImage: cgImg)
        
        return img
    }
    
    public func rotate(orientation orientation: UIImageRotateOrientation) -> UIImage {
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
            transform = CGAffineTransformTranslate(transform, size.width ,-size.height)
            transform = CGAffineTransformScale(transform, -1, 1)
        case .Down :
            transform = CGAffineTransformTranslate(transform, size.width,size.height)
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


