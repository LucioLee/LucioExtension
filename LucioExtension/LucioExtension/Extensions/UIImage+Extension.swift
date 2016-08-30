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
    
    public func circle(withBorderWidth width: CGFloat = 0, borderColor: UIColor = UIColor.black) -> UIImage {
        
        let diameter = min(size.width, size.height)
        precondition(width <= diameter / 2.0, "Border width is too large !")
        
        let originX = (diameter - size.width) / 2.0
        let originY = (diameter - size.height) / 2.0
        let newSize = CGSize(width: diameter, height: diameter)
        UIGraphicsBeginImageContextWithOptions(newSize, false, scale)
        let context = UIGraphicsGetCurrentContext()!
        context.setStrokeColor(borderColor.cgColor)
        context.setLineWidth(width)
        let rect = CGRect(origin: CGPoint.zero, size: newSize)
        context.addEllipse(in: rect)
        context.clip()
        self.draw(in: CGRect(origin: CGPoint(x: originX, y: originY), size: size))
        let offset = round(width / 2.0)
        context.addEllipse(in: rect.insetBy(dx: offset, dy: offset))
        context.strokePath()
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }

    public class func image(with color: UIColor) -> UIImage {
        return image(with: color, and: CGSize(width: 1, height: 1))
    }

    public class func image(with color:UIColor,and size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(CGRect(origin: CGPoint.zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    public func fixOrientation() -> UIImage {
        
        if imageOrientation == .up { return self }
        
        var transform: CGAffineTransform = CGAffineTransform.identity
        
        switch imageOrientation {
        case .left :
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.rotated(by: CGFloat(M_PI_2))
        case .down :
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: CGFloat(M_PI))
        case .right:
            transform = transform.translatedBy(x: 0, y: size.height)
            transform = transform.rotated(by: CGFloat(-M_PI_2))
        case .upMirrored :
            transform = transform.translatedBy(x: size.width,y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .leftMirrored:
            transform = transform.rotated(by: CGFloat(M_PI_2))
            transform = transform.translatedBy(x: size.height ,y: -size.width)
            transform = transform.scaledBy(x: -1, y: 1)
        case .downMirrored:
            transform = transform.translatedBy(x: 0,y: size.height)
            transform = transform.scaledBy(x: 1, y: -1)
        case .rightMirrored:
            transform = transform.rotated(by: CGFloat(M_PI_2))
            transform = transform.scaledBy(x: 1, y: -1)
        default:
            break
        }
        let drawSize = [.left, .leftMirrored, .right, .rightMirrored].contains(imageOrientation) ? CGSize(width: size.height, height: size.width) : CGSize(width: size.width, height: size.height)
        let context = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: cgImage!.bitsPerComponent, bytesPerRow: 0, space: cgImage!.colorSpace!, bitmapInfo: cgImage!.bitmapInfo.rawValue)!
        context.concatenate(transform)
        context.draw(cgImage!, in: CGRect(origin: CGPoint.zero, size:drawSize))
        let cgImg = context.makeImage()!
        let img:UIImage = UIImage(cgImage: cgImg)
        
        return img
    }
    
    public func rotate(orientation: UIImageRotateOrientation) -> UIImage {
        var transform = CGAffineTransform.identity
        switch orientation {
        case .Mirrored :
            transform = transform.translatedBy(x: size.width,y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .Left :
            transform = transform.translatedBy(x: size.height,y: 0)
            transform = transform.rotated(by: CGFloat(M_PI_2))
        case .LeftMirrored :
            transform = transform.rotated(by: CGFloat(M_PI_2))
            transform = transform.translatedBy(x: size.width ,y: -size.height)
            transform = transform.scaledBy(x: -1, y: 1)
        case .Down :
            transform = transform.translatedBy(x: size.width,y: size.height)
            transform = transform.rotated(by: CGFloat(M_PI))
        case .DownMirrored :
            transform = transform.translatedBy(x: 0,y: size.height)
            transform = transform.scaledBy(x: 1, y: -1)
        case .Right :
            transform = transform.translatedBy(x: 0,y: size.width)
            transform = transform.rotated(by: -CGFloat(M_PI_2))
        case .RightMirrored :
            transform = transform.rotated(by: CGFloat(M_PI_2))
            transform = transform.scaledBy(x: 1, y: -1)
        }
        let drawSize = [.Left, .LeftMirrored, .Right, .RightMirrored].contains(orientation) ? CGSize(width: size.height, height: size.width) : CGSize(width: size.width, height: size.height)
        
        let context = CGContext(data: nil, width: Int(drawSize.width), height: Int(drawSize.height), bitsPerComponent: cgImage!.bitsPerComponent,bytesPerRow: 0, space: cgImage!.colorSpace!, bitmapInfo: cgImage!.bitmapInfo.rawValue)!
        context.concatenate(transform)
        context.draw(cgImage!, in: CGRect(x: 0, y: 0, width:size.width, height: size.height))
        let cgImg = context.makeImage()!
        let img =  UIImage(cgImage: cgImg, scale: scale, orientation: imageOrientation)
        return img
    }
}


