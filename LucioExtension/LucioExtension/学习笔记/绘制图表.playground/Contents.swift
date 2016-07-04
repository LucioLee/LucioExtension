//: Playground - noun: a place where people can play

import UIKit

let offset = CGFloat(30)
let lineSpace = CGFloat(20)

public func CGContextMoveToPoint(c: CGContext?, _ point: CGPoint) {
    CGContextMoveToPoint(c, point.x, point.y)
}
public func CGContextAddLineToPoint(c: CGContext?, _ point: CGPoint) {
    CGContextAddLineToPoint(c,point.x,point.y)
}
public func CGContextAddArc(c: CGContext?, _ center: CGPoint, _ radius: CGFloat, _ startAngle: CGFloat, _ endAngle: CGFloat, _ clockwise: Int32) {
    CGContextAddArc(c, center.x, center.y, radius, startAngle, endAngle, clockwise)
}
public func CGContextAddCircle(c: CGContext?, _ center: CGPoint, _ radius: CGFloat) {
    CGContextAddArc(c, center.x, center.y, radius, 0, CGFloat(M_PI * 2), 0)
}
public func pointWithOffset(point:CGPoint,_ offset:CGFloat) -> CGPoint {
    return CGPoint(x: point.x + offset, y: point.y + offset)
}

class LineChartView: UIView {
    
    var linePoints:[CGPoint] = [] {
        didSet{
            setNeedsDisplay()
        }
    }
    var lineColor:UIColor = UIColor.blackColor() {
        didSet {
            setNeedsDisplay()
        }
    }
    var showShadow = true {
        didSet {
            setNeedsDisplay()
        }
    }
//    func drawText(text:String,context:CGContext,postion:CGPoint) {
//        let font = UIFont.systemFontOfSize(8)
//        let ctFont = CTFontCreateWithName(font.fontName,font.pointSize,nil)
//        let cfStr = CFStringCreateWithCString(kCFAllocatorDefault, (text as NSString).UTF8String, CFStringBuiltInEncodings.UTF8.rawValue)
//        let attrCfStr = CFAttributedStringCreate(kCFAllocatorDefault, cfStr, nil)
//        let mattrCfStr = CFAttributedStringCreateMutableCopy(kCFAllocatorDefault, 0, attrCfStr)
//        CFAttributedStringSetAttribute(mattrCfStr, CFRangeMake(0,CFAttributedStringGetLength(mattrCfStr)), kCTFontAttributeName, ctFont)
//        let ctLine = CTLineCreateWithAttributedString(mattrCfStr)
//        CGContextSetTextPosition(context, postion.x,postion.y)
//        CTLineDraw(ctLine, context)
//    }
//    
    override func drawRect(rect: CGRect) {
        
        guard linePoints.count > 0 else {
            return
        }
        
        let context = UIGraphicsGetCurrentContext()
    
        let horizontalLineCount = Int((rect.size.height - offset)/lineSpace)
        let verticalLineCount = Int((rect.size.width - offset)/lineSpace)
        // 画刻度
        for index in (1...horizontalLineCount/2).reverse() {
            let horizontalLineY = rect.size.height - offset - CGFloat(index) * lineSpace * 2
            let text:NSString = "\(index * Int(lineSpace) * 2)"
            let attrs = [NSFontAttributeName:UIFont.systemFontOfSize(8),NSForegroundColorAttributeName:lineColor]
            let size = text.sizeWithAttributes(attrs)
            
            text.drawInRect(CGRectMake((offset - size.width)/2, horizontalLineY - size.height/2, size.width, size.height), withAttributes: attrs)
        }
        for index in 1...verticalLineCount {

            let verticalLineX = CGFloat(index) * lineSpace * 2 + offset
            let text:NSString = "\(index * Int(lineSpace) * 2)"
            let attrs = [NSFontAttributeName:UIFont.systemFontOfSize(8),NSForegroundColorAttributeName:lineColor]
            let size = text.sizeWithAttributes(attrs)
            text.drawInRect(CGRectMake(verticalLineX - size.width/2, rect.size.height - offset/2 - size.height/2, size.width, size.height), withAttributes: attrs)
        }
        
        // 转换坐标系
        CGContextTranslateCTM(context, 0, rect.size.height)
        CGContextScaleCTM(context, 1, -1)
        
        UIColor(red: 220/255.0, green: 220/255.0, blue: 220/255.0, alpha: 1).set()
        
        // 坐标轴
        CGContextMoveToPoint(context, offset, frame.size.height)
        CGContextAddLineToPoint(context,pointWithOffset(CGPoint.zero, offset))
        CGContextAddLineToPoint(context, frame.size.width, offset)
        CGContextDrawPath(context, .Stroke)
        
        CGContextSaveGState(context)
        // 画虚线
        let horizontalMinX = offset
        let horizontalMaxX = rect.size.width

        var length: [CGFloat] = [5,5]
        CGContextSetLineDash(context, 0, &length, 2)
        for index in 1..<horizontalLineCount+1 {
            let horizontalLineY = CGFloat(index) * lineSpace + offset
            CGContextMoveToPoint(context, horizontalMinX, horizontalLineY)
            CGContextAddLineToPoint(context,horizontalMaxX, horizontalLineY)
        }
        let verticalMinY = offset
        let verticalMaxY = rect.size.height
        for index in 1..<verticalLineCount+1 {
            let verticalLineX = CGFloat(index) * lineSpace + offset
            CGContextMoveToPoint(context, verticalLineX, verticalMinY)
            CGContextAddLineToPoint(context,verticalLineX, verticalMaxY)
        }
        CGContextDrawPath(context, .Stroke)
        CGContextRestoreGState(context)
    
        
        // 画线
        lineColor.set()
        for (index,point) in linePoints.enumerate() {
            if index == 0 {
                CGContextMoveToPoint(context, pointWithOffset(point, offset))
            } else {
                CGContextAddLineToPoint(context, pointWithOffset(point, offset))
            }
        }
        CGContextDrawPath(context, .Stroke)
        // 画点
        for point in linePoints {
            CGContextAddCircle(context, pointWithOffset(point, offset), 2)
            CGContextDrawPath(context, .Stroke)
        }
        
        // 画阴影
        if showShadow == true {
            for index in 1..<linePoints.count-1{
                let leftPoint = linePoints[index - 1]
                let point = linePoints[index]
                let rightPoint = linePoints[index + 1]
                if point.y > leftPoint.y && point.y > rightPoint.y {
                    autoreleasepool({ 
                        CGContextMoveToPoint(context, pointWithOffset(leftPoint, offset))
                        CGContextAddLineToPoint(context, pointWithOffset(point, offset))
                        CGContextAddLineToPoint(context, pointWithOffset(rightPoint, offset))
                        CGContextSaveGState(context)
                        CGContextClip(context)
                        let colorSpace = CGColorSpaceCreateDeviceRGB()
                        let colors:CFArray = [lineColor.colorWithAlphaComponent(0.2).CGColor,UIColor.whiteColor().colorWithAlphaComponent(0.3).CGColor]
                        var location:[CGFloat] = [0,1.0]
                        let gradient = CGGradientCreateWithColors(colorSpace, colors, &location)
                        let higherPoint = leftPoint.y > rightPoint.y ? leftPoint : rightPoint
                        CGContextDrawLinearGradient(context, gradient, pointWithOffset(point, offset), pointWithOffset(higherPoint, offset), .DrawsAfterEndLocation)
                        CGContextRestoreGState(context)
                    })
                }
            }
        }
    }
}

let drawView = LineChartView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 1050, height: 650)))
drawView.backgroundColor = UIColor.whiteColor()

drawView.linePoints = [CGPoint.zero,CGPoint(x: 10,y: 120),CGPoint(x: 20,y: 17),CGPoint(x: 30,y: 210),CGPoint(x: 40,y: 40),CGPoint(x: 50,y: 400),CGPoint(x: 60,y: 40),CGPoint(x: 70,y: 100),CGPoint(x: 80,y: 80),CGPoint(x: 90,y: 420),CGPoint(x: 100,y: 43),CGPoint(x: 110,y: 330),CGPoint(x: 120,y: 80),CGPoint(x: 130,y: 120),CGPoint(x: 140,y: 600),CGPoint(x: 150,y: 80),CGPoint(x: 160,y: 557),CGPoint(x: 170,y: 54),CGPoint(x: 180,y: 178),CGPoint(x: 190,y: 89),CGPoint(x: 200,y: 123),CGPoint(x: 210,y: 19),CGPoint(x: 220,y: 105),CGPoint(x: 230,y: 35),CGPoint(x: 240,y: 285),CGPoint(x: 250,y: 60),CGPoint(x: 260,y: 354),CGPoint(x: 270,y: 178),CGPoint(x: 280,y: 89),CGPoint(x: 290,y: 123),CGPoint(x: 300,y: 79),CGPoint(x: 310,y: 165),CGPoint(x: 320,y: 35),CGPoint(x: 330,y: 330),CGPoint(x: 340,y: 80),CGPoint(x: 350,y: 120),CGPoint(x: 360,y: 300),CGPoint(x: 370,y: 80),CGPoint(x: 380,y: 557),CGPoint(x: 390,y: 54),CGPoint(x: 400,y: 285),CGPoint(x: 410,y: 100),CGPoint(x: 420,y: 35),CGPoint(x: 430,y: 285),CGPoint(x: 440,y: 60),CGPoint(x: 450,y: 354),CGPoint(x: 460,y: 178),CGPoint(x: 470,y: 89),CGPoint(x: 480,y: 123),CGPoint(x: 490,y: 79),CGPoint(x: 500,y: 165),CGPoint(x: 510,y: 120),CGPoint(x: 520,y: 17),CGPoint(x: 530,y: 210),CGPoint(x: 540,y: 40),CGPoint(x: 550,y: 400),CGPoint(x: 560,y: 40),CGPoint(x: 570,y: 100),CGPoint(x: 580,y: 80),CGPoint(x: 590,y: 420),CGPoint(x: 600,y: 43),CGPoint(x: 610,y: 330),CGPoint(x: 620,y: 80),CGPoint(x: 630,y: 120),CGPoint(x: 640,y: 600),CGPoint(x: 650,y: 80),CGPoint(x: 660,y: 557),CGPoint(x: 670,y: 54),CGPoint(x: 680,y: 178),CGPoint(x: 690,y: 89),CGPoint(x: 700,y: 123),CGPoint(x: 710,y: 19),CGPoint(x: 720,y: 105),CGPoint(x: 730,y: 35),CGPoint(x: 740,y: 285),CGPoint(x: 750,y: 60),CGPoint(x: 760,y: 354),CGPoint(x: 770,y: 178),CGPoint(x: 780,y: 89),CGPoint(x: 790,y: 123),CGPoint(x: 800,y: 79),CGPoint(x: 810,y: 165),CGPoint(x: 820,y: 35),CGPoint(x: 830,y: 330),CGPoint(x: 840,y: 80),CGPoint(x: 850,y: 120),CGPoint(x: 860,y: 300),CGPoint(x: 870,y: 80),CGPoint(x: 880,y: 557),CGPoint(x: 890,y: 54),CGPoint(x: 900,y: 285),CGPoint(x: 910,y: 100),CGPoint(x: 920,y: 35),CGPoint(x: 930,y: 285),CGPoint(x: 940,y: 60),CGPoint(x: 950,y: 354),CGPoint(x: 960,y: 178),CGPoint(x: 970,y: 89),CGPoint(x: 980,y: 123),CGPoint(x: 990,y: 79),CGPoint(x: 1000,y: 165)]
drawView.lineColor = UIColor.magentaColor()
let label = UILabel()
label.textColor = drawView.lineColor
label.font = UIFont.systemFontOfSize(8)
label.text = "指数/时间"
label.frame = CGRectMake(10, drawView.frame.size.height - 20, 10, 10)
label.transform = CGAffineTransformMakeRotation(-CGFloat(M_PI_2/2))
label.sizeToFit()
drawView.addSubview(label)
drawView



