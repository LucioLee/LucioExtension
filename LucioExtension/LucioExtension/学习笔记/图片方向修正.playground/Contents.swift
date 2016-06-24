import UIKit
import XCPlayground

public extension UIImage {
    
    func fixOrientation() -> UIImage {
        
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
}
/*:
 - experiment:
    在iPhone中显示正常的照片，在其它设备中打开，图片会发生旋转。这是因为手机横屏，且Home键在右侧时，才是iPhone手机相机的正方向。任何发生旋转的图片都是非相机正方向拍摄造成的。比如，手机正方向(Home位于下方)拍摄的照片，在相机正方向(Home位于右侧)查看，照片是倒着的(往左旋转90度)，这是照片的物理方向，而iPhone设备会记录照相时相机的旋转方向，存储于TIFF中(`MacOS中打开预览>工具>显示检查器>TIFF`)，然后根据TIFF信息将照片旋转到适宜角度后显示给用户，而我们在传输照片的过程中会丢失TIFF信息或者目标设备不支持根据TIFF信息自动旋转照片，直接显示物理方向，才会造成这一现象。而我们只要将照片的物理角度旋转到用户在iPhone上看到的角度，并将TIFF信息设置为默认(图片向上),就能避免这种现象了。
 */
let image = [#Image(imageLiteral: "bg.jpeg")#]
let up                 = UIImage(CGImage: image.CGImage!, scale: image.scale, orientation: .Up)
let upMirrored         = UIImage(CGImage: image.CGImage!, scale: image.scale, orientation: .UpMirrored)
let left               = UIImage(CGImage: image.CGImage!, scale: image.scale, orientation: .Left)
let leftMirrored       = UIImage(CGImage: image.CGImage!, scale: image.scale, orientation: .LeftMirrored)
let down               = UIImage(CGImage: image.CGImage!, scale: image.scale, orientation: .Down)
let downMirrored       = UIImage(CGImage: image.CGImage!, scale: image.scale, orientation: .DownMirrored)
let right              = UIImage(CGImage: image.CGImage!, scale: image.scale, orientation: .Right)
let rightMirrored      = UIImage(CGImage: image.CGImage!, scale: image.scale, orientation: .RightMirrored)
/*:
 - important:
    修改图片方向属性*imageOrientation*并不会影响图片的物理方向，只会影响在设备中的显示方向。但是，Playground的*timeline*不会显示方向修改后的图片和方向，比如Size(700,1244)的图片,imageOrientation设置为Left,在设备上会左转90度，Size会变为(1244.0, 700.0)，在timeline中查看，显示的还是物理图片和物理尺寸。
 */
let fiexedUp           = UIImage(CGImage: image.CGImage!, scale: image.scale, orientation: .Up).fixOrientation()
let fixedUpMirrored    = UIImage(CGImage: image.CGImage!, scale: image.scale, orientation: .UpMirrored).fixOrientation()
let fixedLeft          = UIImage(CGImage: image.CGImage!, scale: image.scale, orientation: .Left).fixOrientation()
let fixedLeftMirrored  = UIImage(CGImage: image.CGImage!, scale: image.scale, orientation: .LeftMirrored).fixOrientation()
let fixedDown          = UIImage(CGImage: image.CGImage!, scale: image.scale, orientation: .Down).fixOrientation()
let fixedDownMirrored  = UIImage(CGImage: image.CGImage!, scale: image.scale, orientation: .DownMirrored).fixOrientation()
let fixedRight         = UIImage(CGImage: image.CGImage!, scale: image.scale, orientation: .Right).fixOrientation()
let fixedRightMirrored = UIImage(CGImage: image.CGImage!, scale: image.scale, orientation: .RightMirrored).fixOrientation()

/*:
 - note:
 Playground没有沙盒，文件会默认写入到~/Document/Shared Playground Data文件路径下,Shared Playground Data文件夹需要自己创建
 */
func writeToComputerDocumentWithName(image:UIImage,named name:String) {
    
    let fileURL = XCPlaygroundSharedDataDirectoryURL.URLByAppendingPathComponent(name + ".jpeg")
    do {
        try UIImageJPEGRepresentation(image, 1)?.writeToURL(fileURL, options: .DataWritingAtomic)
    } catch let error as NSError {
        print(error.localizedDescription)
    }
}

/*:
 - note:
 修正前后的照片在预览中看上去是一样的，但是物理方向并不一样，可以查看TIFF属性，通过旋转等操作将图片转到正常方向查看
 */
//writeToComputerDocumentWithName(up,named: "up")
//writeToComputerDocumentWithName(upMirrored,named: "upMirrored")
//writeToComputerDocumentWithName(left,named: "left")
//writeToComputerDocumentWithName(leftMirrored,named: "leftMirrored")
//writeToComputerDocumentWithName(down,named: "down")
//writeToComputerDocumentWithName(downMirrored,named: "downMirrored")
//writeToComputerDocumentWithName(right,named: "right")
//writeToComputerDocumentWithName(rightMirrored,named: "rightMirrored")
//
//writeToComputerDocumentWithName(fiexedUp,named: "fiexedUp")
//writeToComputerDocumentWithName(fixedUpMirrored,named: "fixedUpMirrored")
//writeToComputerDocumentWithName(fixedLeft,named: "fixedLeft")
//writeToComputerDocumentWithName(fixedLeftMirrored,named: "fixedLeftMirrored")
//writeToComputerDocumentWithName(fixedDown,named: "fixedDown")
//writeToComputerDocumentWithName(fixedDownMirrored,named: "fixedDownMirrored")
//writeToComputerDocumentWithName(fixedRight,named: "fixedRight")
//writeToComputerDocumentWithName(fixedRightMirrored,named: "fixedRightMirrored")
