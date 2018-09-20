//
//  UIImageView+Extensions.swift
//  LegoKit
//
//  Created by forkon on 2018/9/18.
//

import UIKit

extension UIImageView {
    
    func setTemplateImage(_ image: UIImage?, color: UIColor) {
        self.image = image?.withRenderingMode(.alwaysTemplate)
        tintColor = color
    }
    
}
