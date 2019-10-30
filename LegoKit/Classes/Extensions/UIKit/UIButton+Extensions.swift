//
//  UIButton+Extensions.swift
//  LegoKit
//
//  Created by forkon on 2018/11/27.
//

import UIKit

extension UIButton {
    
    private struct AssociatedKeys {
        static var imageTitleSpaceKey: UInt8 = 8
    }
    
    public var imageTitleSpace: CGFloat {
        set(newSpace) {
            objc_setAssociatedObject(self, &AssociatedKeys.imageTitleSpaceKey, newSpace, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
            
            imageEdgeInsets = UIEdgeInsets(top: 0.0, left: -newSpace / 2.0, bottom: 0.0, right: newSpace / 2.0)
            titleEdgeInsets = UIEdgeInsets(top: 0.0, left: newSpace / 2.0, bottom: 0.0, right: -newSpace / 2.0)
            
            layoutIfNeeded()
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.imageTitleSpaceKey) as! CGFloat
        }
    }
    
}

public extension UIButton {

    enum CornerRadius {
        case custom(radius: CGFloat)
        case halfHeight
    }

    func set(
        title: String,
        titleFont: UIFont,
        imageOnTitleLeft: UIImage?,
        imageOnTitleRight: UIImage?,
        margins: UIEdgeInsets,
        borderColor: UIColor = UIColor.black,
        borderWidth: CGFloat = 1.0,
        cornerRadius: CornerRadius
        ) {
        let space = "  "
        let leftImagePlaceholder = "#LeftImage#"
        let rightImagePlaceholder = "#RightImage#"
        let attributedTitle = NSMutableAttributedString(string: "\(leftImagePlaceholder)\(space)\(title)\(space)\(rightImagePlaceholder)")

        attributedTitle.setAttributes(
            [
                NSAttributedString.Key.font : titleFont
            ],
            range: NSRange(location: 0, length: attributedTitle.length)
        )

        if let imageInTitleLeftSide = imageOnTitleLeft {
            let imageWidth = imageInTitleLeftSide.size.width
            let imageHeight = imageInTitleLeftSide.size.height

            let leftImageAttachment = NSTextAttachment(data: nil, ofType: nil)
            leftImageAttachment.bounds = CGRect(x: 0.0, y: (titleFont.capHeight - imageHeight).rounded() / 2, width: imageWidth, height: imageHeight)
            leftImageAttachment.image = imageInTitleLeftSide

            let leftImageString = NSAttributedString(attachment: leftImageAttachment)

            attributedTitle.replaceCharacters(in: (attributedTitle.string as NSString).range(of: leftImagePlaceholder), with: leftImageString)
        }

        if let imageInTitleRightSide = imageOnTitleRight {
            let imageWidth = imageInTitleRightSide.size.width
            let imageHeight = imageInTitleRightSide.size.height

            let rightImageAttachment = NSTextAttachment(data: nil, ofType: nil)
            rightImageAttachment.bounds = CGRect(x: 0.0, y: (titleFont.capHeight - imageHeight).rounded() / 2, width: imageWidth, height: imageHeight)
            rightImageAttachment.image = imageInTitleRightSide

            let rightImageString = NSAttributedString(attachment: rightImageAttachment)

            attributedTitle.replaceCharacters(in: (attributedTitle.string as NSString).range(of: rightImagePlaceholder), with: rightImageString)
        }

        setAttributedTitle(attributedTitle, for: .normal)

        contentEdgeInsets = margins

        sizeToFit()

        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth

        switch cornerRadius {
        case .custom(let radius):
            layer.cornerRadius = radius
        case .halfHeight:
            layer.cornerRadius = bounds.height / 2
        }
    }

}
