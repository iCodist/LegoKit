//
//  Array+Extensions.swift
//  LegoKit
//
//  Created by forkon on 2018/10/26.
//

import UIKit

extension Array {
    
    /// [0, 1, 2, 3, 4].splitBy(subSize: 2) -> [[0, 1], [2, 3], [4]]
    public func splitBy(subSize: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: subSize).map{ fromIndex in
            let toIndex = Swift.min(fromIndex.advanced(by: subSize), self.endIndex)
            return Array(self[fromIndex ..< toIndex])
        }
    }
    
}
