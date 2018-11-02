//
//  PHFetchResult+Extensions.swift
//  LegoKit
//
//  Created by forkon on 2018/10/29.
//

import Photos

extension PHFetchResult {
    
    @objc public func groupIntoDays() -> [[PHAsset]] {
        var assetsGroupedByDate = [[PHAsset]]()
        var currentDateOfFilter = Date()
        var currentAssetsGroup = [PHAsset]()
        
        // loop through PHFetchResult to separate into arrays where all dates are the same
        for index in 0..<self.count {
            let value = object(at: index) as! PHAsset
            if currentDateOfFilter.isSameDay(value.creationDate!) {
                currentAssetsGroup.append(value)
            } else {
                if currentAssetsGroup.count > 0 {
                    assetsGroupedByDate.append(currentAssetsGroup)
                }
                currentAssetsGroup = []
                currentAssetsGroup.append(value)
                currentDateOfFilter = value.creationDate!
            }
        }
        
        if currentAssetsGroup.count > 0 {
            assetsGroupedByDate.append(currentAssetsGroup)
        }
        
        return assetsGroupedByDate
    }
    
}

