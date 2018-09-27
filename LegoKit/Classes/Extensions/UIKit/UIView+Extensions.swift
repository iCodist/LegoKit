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
        return constraints.filter{$0.firstAttribute == .width && $0.secondItem == nil}.first
    }
    
    public var heightConstraint: NSLayoutConstraint? {
        return constraints.filter{$0.firstAttribute == .height && $0.secondItem == nil}.first
    }
    
    public var bottomConstraint: NSLayoutConstraint? {
        guard let superview = superview else {
            return nil
        }
        
        return superview.constraints.filter{$0.firstAttribute == .bottom && ($0.firstItem as? UIView) == self}.first
    }

}
