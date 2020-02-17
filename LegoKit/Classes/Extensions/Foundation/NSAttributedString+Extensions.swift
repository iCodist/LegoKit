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

    convenience init(string: String, font: UIFont, textColor: UIColor, indent: CGFloat) {
        let style: NSMutableParagraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        style.firstLineHeadIndent = indent
        style.headIndent = indent
        style.tailIndent = -indent

        let attributes = [
            NSAttributedString.Key.paragraphStyle : style,
            NSAttributedString.Key.font : font,
            NSAttributedString.Key.foregroundColor : textColor
        ]

        self.init(string: string, attributes: attributes)
    }

}
