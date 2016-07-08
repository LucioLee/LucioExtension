//
//  PlaceHolderTextView.swift
//  PlaceHolderTextView
//
//  Created by Lucio on 16/7/8.
//  Copyright © 2016年 Lucio. All rights reserved.
//

import UIKit

public class PlaceHolderTextView: UITextView {
    
    private var _placeHolderLabel: UILabel!
    
    public var attributedPlaceHolder: NSAttributedString? = nil {
        didSet {
            _placeHolderLabel.attributedText = attributedPlaceHolder
            setNeedsDisplay()
        }
    }
    
    public var placeHolder: String? = nil {
        didSet {
            _placeHolderLabel.text = placeHolder
            setNeedsDisplay()
        }
    }
    
    override public var text: String! {
        didSet {
            textDidChange()
        }
    }
    
    override public var font: UIFont? {
        didSet {
            if _placeHolderLabel != nil {
                _placeHolderLabel.font = font
            }
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        let size =  _placeHolderLabel.sizeThatFits(CGSize(width: bounds.width - 10 ,height: CGFloat(MAXFLOAT)))
        _placeHolderLabel.frame = CGRect(origin: CGPoint(x: 5,y: 5), size: size)
    }
    
    
    override public init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        addPlaceHolderLabel()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addPlaceHolderLabel()
        textDidChange()
    }
    
    private func addPlaceHolderLabel() {
        _placeHolderLabel = UILabel()
        _placeHolderLabel.numberOfLines = 0
        _placeHolderLabel.font = self.font ?? UIFont.systemFontOfSize(16)
        _placeHolderLabel.textColor = UIColor.lightGrayColor()
        _placeHolderLabel.backgroundColor = UIColor.clearColor()
        addSubview(_placeHolderLabel)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PlaceHolderTextView.textDidChange), name: UITextViewTextDidChangeNotification, object: self)
    }
    
    final func textDidChange() {
        _placeHolderLabel.hidden = text.isEmpty ? false : true
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}