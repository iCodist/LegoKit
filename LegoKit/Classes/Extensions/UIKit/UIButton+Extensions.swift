//
//  UIButton+Extensions.swift
//  LegoKit
//
//  Created by forkon on 2018/11/27.
//

import UIKit

extension UIButton {
    
    private struct AssociatedKeys {
        static var imageTitleSpaceKey: UInt8 = 8
    }
    
    public var imageTitleSpace: CGFloat {
        set(newSpace) {
            objc_setAssociatedObject(self, &AssociatedKeys.imageTitleSpaceKey, newSpace, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
            
            imageEdgeInsets = UIEdgeInsets(top: 0.0, left: -newSpace / 2.0, bottom: 0.0, right: newSpace / 2.0)
            titleEdgeInsets = UIEdgeInsets(top: 0.0, left: newSpace / 2.0, bottom: 0.0, right: -newSpace / 2.0)
            
            layoutIfNeeded()
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.imageTitleSpaceKey) as! CGFloat
        }
    }
    
}
