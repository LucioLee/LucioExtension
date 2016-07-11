//
//  UITextView+Extension.swift
//  LucioExtension
//
//  Created by 李新新 on 16/7/8.
//  Copyright © 2016年 Person. All rights reserved.
//

import UIKit

private var KAttributePlaceHolder = "KAttributePlaceHolder"
private var KPlaceHolder = "KPlaceHolder"

public extension UITextView {
    
    public var ex_attributePlaceHolder: NSAttributedString? {
        get {
            return objc_getAssociatedObject(self, &KAttributePlaceHolder) as? NSAttributedString
        }
        set {
            objc_setAssociatedObject(self, &KAttributePlaceHolder,newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    public var ex_placeHolder: NSAttributedString? {
        get {
            return objc_getAssociatedObject(self, &KPlaceHolder) as? NSAttributedString
        }
        set {
            objc_setAssociatedObject(self, &KPlaceHolder,newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
}
