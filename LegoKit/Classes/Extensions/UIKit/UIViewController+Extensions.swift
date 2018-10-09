//
//  UIViewController+Extensions.swift
//  LegoKit
//
//  Created by forkon on 16/6/30.
//
//

import UIKit

public extension UIViewController {

    class func instantiateFromNib() -> Self {
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

extension UIPopoverPresentationController {
    
    fileprivate struct AssociatedKeys {
        static var didDismissClosureKey: Int = 8888
    }
    
    fileprivate var didDismissClosure: (() -> ())? {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.didDismissClosureKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.didDismissClosureKey) as? (() -> ())
        }
    }
    
}

extension UIViewController: UIPopoverPresentationControllerDelegate {
    
    public func popout(_ viewControllerToPopout: UIViewController, preferredContentSize: CGSize, from sourceView: UIView, didPresent: (() -> ())? = nil, didDismiss: (() -> ())? = nil) {
        viewControllerToPopout.modalPresentationStyle = .popover
        viewControllerToPopout.preferredContentSize = preferredContentSize
        viewControllerToPopout.popoverPresentationController?.sourceView = sourceView
        viewControllerToPopout.popoverPresentationController?.sourceRect = sourceView.bounds
        viewControllerToPopout.popoverPresentationController?.permittedArrowDirections = .up
        viewControllerToPopout.popoverPresentationController?.delegate = self
        viewControllerToPopout.popoverPresentationController?.didDismissClosure = didDismiss
        
        present(viewControllerToPopout, animated: true, completion: didPresent)
    }
    
    public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    public func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        popoverPresentationController.didDismissClosure?()
        popoverPresentationController.didDismissClosure = nil
    }
    
    public func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }
    
}
