//
//  StringExtension.swift
//  LegoKit
//
//  Created by forkon on 15/12/31.
//


extension String {

    public func localizedString() -> String {
        return NSLocalizedString(self, comment: self)
    }
    
}

// MARK: - 添加下标操作
public extension String {
    
    subscript(pos: Int) -> String {
        precondition(pos >= 0, "character position can't be negative")
        guard pos < characters.count else { return "" }
        let idx = index(startIndex, offsetBy: pos)
        return String(self[idx...idx])
    }
    
    subscript(range: CountableRange<Int>) -> String {
        precondition(range.lowerBound.distance(to: 0) <= 0, "range lowerBound can't be negative")
        let lowerIndex = index(startIndex, offsetBy: range.lowerBound, limitedBy: endIndex) ?? endIndex
        return String(self[lowerIndex..<(index(lowerIndex, offsetBy: range.upperBound - range.lowerBound, limitedBy: endIndex) ?? endIndex)])
    }
    
    subscript(range: ClosedRange<Int>) -> String {
        precondition(range.lowerBound.distance(to: 0) <= 0, "range lowerBound can't be negative")
        let lowerIndex = index(startIndex, offsetBy: range.lowerBound, limitedBy: endIndex) ?? endIndex
        return String(self[lowerIndex..<(index(lowerIndex, offsetBy: range.upperBound - range.lowerBound + 1, limitedBy: endIndex) ?? endIndex)])
    }
    
}
