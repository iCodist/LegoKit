//
//  UIViewController+Extensions.swift
//  LegoKit
//
//  Created by forkon on 16/6/30.
//
//

import UIKit

public extension UIViewController {

    class func df_instantiateFromNib() -> Self {
        var className: String = NSStringFromClass(self.classForKeyedUnarchiver()).components(separatedBy: ".")[1]
        if UIDevice.current.isIPad() {
            if let _ = Bundle.main.path(forResource: "\(className)_iPad", ofType: "nib") {
                className = "\(className)_iPad"
            }
        }
        let vc = self.init(nibName: className, bundle: nil)
        return vc
    }
    
}
