//
//  DispatchTimeExtension.swift
//  LegoKit
//
//  Created by forkon on 2016/12/7.
//
//

import UIKit

/// 有了下面这两段代码你就可以这样使用DispatchQueue了：
/// DispatchQueue.main.asyncAfter(deadline: 8.0) { /* ... */ }

extension DispatchTime: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = DispatchTime.now() + .seconds(value)
    }
}

extension DispatchTime: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = DispatchTime.now() + .milliseconds(Int(value * 1000))
    }
}
