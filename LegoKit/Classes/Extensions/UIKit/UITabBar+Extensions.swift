//
//  UITabBar+Extensions.swift
//  LegoKit
//
//  Created by forkon on 2019/6/11.
//

import UIKit

extension UITabBar {

    public func tabBarItemView(at index: Int) -> UIView? {
        guard let tabBarButtonClass = NSClassFromString("UITabBarButton") else {
            return nil
        }

        let tabBarButtons = subviews.filter{$0.isKind(of: tabBarButtonClass)}
        if !tabBarButtons.isEmpty, index >= 0 && index < tabBarButtons.count {
            return tabBarButtons[index]
        } else {
            return nil
        }
    }

}
