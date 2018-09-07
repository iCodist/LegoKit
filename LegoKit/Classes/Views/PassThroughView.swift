//
//  PassThroughView.swift
//  LegoKit
//
//  Created by forkon on 2018/9/7.
//

import UIKit

class PassThroughView: UIView {

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        for subView in subviews.reversed() {
            if let view = subView.hitTest(convert(point, to: subView), with: event) {
                return view
            }
        }
        return nil;
    }

}
