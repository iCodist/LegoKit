//
//  UIView+Extensions.swift
//  LegoKit
//
//  Created by forkon on 2018/9/6.
//

import UIKit

extension UIView: NibCreatable {}

extension UIView {
    
    public var widthConstraint: NSLayoutConstraint? {
        return constraints.filter{$0.firstAttribute == .width}.first
    }
    
    public var heightConstraint: NSLayoutConstraint? {
        return constraints.filter{$0.firstAttribute == .height}.first
    }
    
}
