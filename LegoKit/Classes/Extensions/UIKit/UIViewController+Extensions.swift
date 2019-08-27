//
//  UIViewController+Extensions.swift
//  LegoKit
//
//  Created by forkon on 16/6/30.
//
//

import UIKit

import Photos
import AVKit

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

    func embedInNavigationController() -> UINavigationController {
        return embedInNavigationController(navBarClass: nil)
    }

    func embedInNavigationController(navBarClass: AnyClass?) -> UINavigationController {
        let nav = UINavigationController(navigationBarClass: navBarClass, toolbarClass: nil)
        nav.viewControllers = [self]
        return nav
    }
    
}

extension UIViewController {
    
    @objc public func alert(title: String? = nil, message: String?) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: .cancel, handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
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

extension UIViewController {
    
    public func playVideo(_ videoAsset:PHAsset) {
        guard videoAsset.mediaType == PHAssetMediaType.video else {
            alert(message: NSLocalizedString("Not a valid video media type.", comment: "Not a valid video media type."))
            return
        }
        
        PHCachingImageManager().requestAVAsset(forVideo: videoAsset, options: nil) { [weak self] (asset, _, _) in
            
            guard let asset = asset else {
                self?.alert(message: NSLocalizedString("Cannot find video asset.", comment: "Cannot find video asset."))
                return
            }
            
            DispatchQueue.main.async {
                guard let strongSelf = self else {
                    return
                }
                
                let item = AVPlayerItem(asset: asset)
                let player = AVPlayer(playerItem: item)
                let playerViewController = CustomAVPlayerViewController()
                playerViewController.player = player
                strongSelf.present(playerViewController, animated: true, completion: {
                    player.play()
                })
            }
        }
    }
    
}

fileprivate class CustomAVPlayerViewController: AVPlayerViewController {
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.landscape, UIInterfaceOrientationMask.portrait]
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
}
