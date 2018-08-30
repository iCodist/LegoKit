//
//  UICollectionView+Extensions.swift
//  LegoKit
//
//  Created by forkon on 2018/8/30.
//

import UIKit

extension UICollectionView {
    
    public func cellFrame(at indexPath: IndexPath) -> CGRect? {
        guard let layoutAttributes = collectionViewLayout.layoutAttributesForItem(at: indexPath) else {
            return nil
        }
        return layoutAttributes.frame
    }
    
}
