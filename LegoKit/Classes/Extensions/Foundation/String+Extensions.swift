//
//  StringExtension.swift
//  LegoKit
//
//  Created by forkon on 15/12/31.
//

import Foundation

extension String {

    public func localizedString() -> String {
        return NSLocalizedString(self, comment: self)
    }
    
}

// MARK: - 添加下标操作
public extension String {
    
    subscript(pos: Int) -> String {
        precondition(pos >= 0, "character position can't be negative")
        guard pos < count else { return "" }
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

extension String {
    
    public func substrings(matched regex: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: self, range: NSRange(startIndex..., in: self))
            return results.map {
                String(self[Range($0.range, in: self)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
}

extension String {
    
    public func substring(between head: String, and tail: Character) -> String? {
        var retval: String? = nil
        if let headUpperBound = range(of: head)?.upperBound {
            var index = headUpperBound
            while self[index] != tail {
                if retval == nil {
                    retval = ""
                }
                retval?.append("\(self[index])")
                index = self.index(index, offsetBy: 1)
            }
        }
        return retval
    }
    
}

public extension String {
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = capitalizingFirstLetter()
    }
    
}

public extension String {
    
    func mutableAttributed(with attributes: [NSAttributedString.Key : Any]?) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: self, attributes: attributes)
    }
    
}

public extension NSMutableAttributedString {
    
    func addAttributes(_ attributes: [NSAttributedString.Key : Any], for substring: String) -> NSMutableAttributedString {
        if let range = string.range(of: substring) {
            addAttributes(attributes, range: NSRange(range, in: string))
        }
        return self
    }
    
}
