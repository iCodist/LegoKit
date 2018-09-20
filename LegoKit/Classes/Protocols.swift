//
//  Protocols.swift
//  LegoKit
//
//  Created by forkon on 2018/9/6.
//

import UIKit

public protocol NibCreatable {
    static func createFromNib(owner: Any?) -> Self?
}

extension NibCreatable where Self: AnyObject {
    
    public static func createFromNib(owner: Any?) -> Self? {
        guard let nibName = nibName else {
            return nil
        }
        let bundleContents = Bundle.main.loadNibNamed(nibName, owner: owner, options: nil)
        guard let result = bundleContents?.last as? Self else {
            return nil
        }
        return result
    }
    
    public static var nibName: String? {
        guard let n = NSStringFromClass(Self.self).components(separatedBy: ".").last else {
            return nil
        }
        return n
    }
    
}

public protocol Cutoutable {
    func cut(_ rectToCut: CGRect)
}

extension Cutoutable where Self: UIView {
    
    public func cut(_ rectToCut: CGRect) {
        let path = UIBezierPath(rect: bounds)
        path.append(UIBezierPath(rect: rectToCut))
        
        let maskLayer = CAShapeLayer()
        maskLayer.fillRule = kCAFillRuleEvenOdd
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }
    
}
