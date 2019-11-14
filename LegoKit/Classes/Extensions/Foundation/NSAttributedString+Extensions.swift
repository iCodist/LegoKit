//
//  NSAttributedString+Extensions.swift
//  LegoKit
//
//  Created by forkon on 2019/11/14.
//

public extension NSAttributedString {

    func size(constrainedToWidth width: CGFloat) -> CGSize {
        let framesetter = CTFramesetterCreateWithAttributedString(self)
        return CTFramesetterSuggestFrameSizeWithConstraints(
            framesetter,
            CFRange(location: 0,length: 0),
            nil,
            CGSize(width: width, height: CGFloat.greatestFiniteMagnitude),
            nil
        )
    }

}
