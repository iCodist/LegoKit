//
//  UITableView+Extensions.swift
//  LegoKit
//
//  Created by forkon on 2019/7/17.
//

import UIKit

extension UITableView {

    func removeSeparatorOnLastCell() {
        tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.001))
    }
    
}
