//
//  CGRect+Extensions.swift
//  LegoKit
//
//  Created by forkon on 2018/11/2.
//

import UIKit

extension CGRect {
    
    public var shorterEdge: CGFloat {
        return min(width, height)
    }
    
    public var longerEdge: CGFloat {
        return max(width, height)
    }
    
}
