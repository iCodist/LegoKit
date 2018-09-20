//
//  PassThroughView.swift
//  LegoKit
//
//  Created by forkon on 2018/9/7.
//

import UIKit

public class PassThroughView: UIView {

    override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        for subView in subviews.reversed() {
            if let view = subView.hitTest(convert(point, to: subView), with: event), !subView.isHidden {
                return view
            }
        }
        return nil;
    }

}
