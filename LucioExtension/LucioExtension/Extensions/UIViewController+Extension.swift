//
//  UIViewController+Extension.swift
//  Daiqian
//
//  Created by 李新新 on 16/4/20.
//  Copyright © 2016年 Hangzhou Suidifu Network Technology Co., Ltd. All rights reserved.
//

import UIKit


public protocol SegueHandlerType {
    associatedtype SegueIdentifiers: RawRepresentable
}

public extension SegueHandlerType where Self: UIViewController,SegueIdentifiers.RawValue == String {
    
    func performSegueWithIdentifier(_ segueIdentifier:SegueIdentifiers,sender:AnyObject?) {
        performSegue(withIdentifier: segueIdentifier.rawValue, sender: sender)
    }
    
    func segueIdentifierForSegue(_ segue:UIStoryboardSegue) -> SegueIdentifiers {
        guard let identifier = segue.identifier, let segueIdentifier = SegueIdentifiers(rawValue: identifier) else {
            fatalError("Invalid segue identifier \(segue.identifier)")
        }
        return segueIdentifier
    }
}


