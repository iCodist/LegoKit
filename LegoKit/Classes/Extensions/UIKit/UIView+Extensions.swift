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

extension UIView {
    
    public func fadedLeftRightEdges(leftEdgeInset: CGFloat = 0.0, rightEdgeInset: CGFloat = 0.0) {
        let maskLayer = CAGradientLayer()
        maskLayer.frame = CGRect(x: leftEdgeInset, y: 0.0, width: bounds.width - rightEdgeInset, height: bounds.height)
        maskLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor, UIColor.black.cgColor, UIColor.clear.cgColor]
        maskLayer.locations = [0.0, 0.1, 0.9, 1.0]
        maskLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        maskLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        layer.mask = maskLayer
    }
    
    public func setGradientBackgroundColor(from fromColor: UIColor, to toColor: UIColor) {
        backgroundColor = UIColor.clear
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [fromColor.cgColor, toColor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        layer.insertSublayer(gradientLayer, at: 0)
    }

}

extension UIView {

    public func clone() -> UIView {
        let data = NSKeyedArchiver.archivedData(withRootObject: self)
        return NSKeyedUnarchiver.unarchiveObject(with: data) as! UIView
    }

}

extension UIView {

    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContext(self.frame.size)
            self.layer.render(in:UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return UIImage(cgImage: image!.cgImage!)
        }
    }

}
