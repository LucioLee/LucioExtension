//
//  InsetsLabel.swift
//  InsetsLabel
//
//  Created by LucioLee on 16/3/9.
//
//

import UIKit

@IBDesignable public class InsetsLabel: UILabel {
    
    public var insets = UIEdgeInsetsZero
    
    @IBInspectable public var top: CGFloat {
        set {
            insets.top = newValue
        }
        get {
            return insets.top
        }
    }
    
    @IBInspectable public var left: CGFloat {
        set {
            insets.left = newValue
        }
        get {
            return insets.left
        }
    }
    
    @IBInspectable public var bottom: CGFloat {
        set {
            insets.bottom = newValue
        }
        get {
            return insets.bottom
        }
    }
    
    @IBInspectable public var right: CGFloat {
        set {
            insets.right = newValue
        }
        get {
            return insets.right
        }
    }
    
    convenience public init(insets: UIEdgeInsets) {
        self.init()
        self.insets = insets;
    }
    
    convenience public init(frame: CGRect, insets: UIEdgeInsets) {
        self.init(frame:frame)
        self.insets = insets
    }
    
    override public func textRectForBounds(bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        return super.textRectForBounds(UIEdgeInsetsInsetRect(bounds, insets), limitedToNumberOfLines: numberOfLines)
    }
    
    override public func intrinsicContentSize() -> CGSize {
        var size = super.intrinsicContentSize()
        size.width  += insets.left + insets.right
        size.height += insets.top + insets.bottom
        return size
    }
    
    override public func drawTextInRect(rect: CGRect) {
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, insets))
    }
}