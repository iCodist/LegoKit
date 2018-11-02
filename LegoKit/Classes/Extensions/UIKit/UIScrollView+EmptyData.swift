//
//  UIScrollView+Extensions.swift
//  Hachi
//
//  Created by forkon on 2018/10/29.
//  Copyright © 2018 Transee. All rights reserved.
//

import UIKit

internal struct Selectors {
    static let tableViewSwizzledReloadData = #selector(UIScrollView.tb_tableViewSwizzledReloadData)
    static let tableViewSwizzledEndUpdates = #selector(UIScrollView.tb_tableViewSwizzledEndUpdates)
    static let collectionViewSwizzledReloadData = #selector(UIScrollView.tb_collectionViewSwizzledReloadData)
    static let collectionViewSwizzledPerformBatchUpdates = #selector(UIScrollView.tb_collectionViewSwizzledPerformBatchUpdates(_:completion:))
}

internal struct TableViewSelectors {
    static let reloadData = #selector(UITableView.reloadData)
    static let endUpdates = #selector(UITableView.endUpdates)
    static let numberOfSections = #selector(UITableViewDataSource.numberOfSections(in:))
}

internal struct CollectionViewSelectors {
    static let reloadData = #selector(UICollectionView.reloadData)
    static let numberOfSections = #selector(UICollectionViewDataSource.numberOfSections(in:))
    static let performBatchUpdates = #selector(UICollectionView.performBatchUpdates(_:completion:))
}

extension UIScrollView {

    // MARK: - Properties
    
    private struct AssociatedKeys {
        static var emptyDataViewKey: UInt8 = 88
    }
    
    @objc open var emptyDataView: UIView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.emptyDataViewKey) as? UIView
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.emptyDataViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                
                switch self {
                case is UITableView:
                    UITableView.tb_swizzleTableViewReloadData
                    UITableView.tb_swizzleTableViewEndUpdates
                case is UICollectionView:
                    UICollectionView.tb_swizzleCollectionViewReloadData
                    UICollectionView.tb_swizzleCollectionViewPerformBatchUpdates
                default:
                    break
                }
            } else {
                handlingInvalidEmptyDataSet()
            }
        }
    }
    
    // MARK: - Public
    
    @objc public func updateEmptyDataSetIfNeeded() {
        reloadEmptyDataSet()
    }
    
    // MARK: - Helper
    
    fileprivate func cellsCount() -> Int {
        var count = 0
        if let tableView = self as? UITableView {
            if let dataSource = tableView.dataSource {
                if dataSource.responds(to: TableViewSelectors.numberOfSections) {
                    let sections = dataSource.numberOfSections?(in: tableView) ?? 0
                    for section in 0..<sections {
                        count += dataSource.tableView(tableView, numberOfRowsInSection: section)
                    }
                }
            }
        } else if let collectionView = self as? UICollectionView {
            if let dataSource = collectionView.dataSource {
                if dataSource.responds(to: CollectionViewSelectors.numberOfSections) {
                    let sections = dataSource.numberOfSections?(in: collectionView) ?? 0
                    for section in 0..<sections {
                        count += dataSource.collectionView(collectionView, numberOfItemsInSection: section)
                    }
                }
            }
        }
        
        return count
    }
    
    // MARK: - Display
    
    fileprivate func handlingInvalidEmptyDataSet() {
        emptyDataView?.removeFromSuperview()
        isScrollEnabled = true
    }
    
    fileprivate func reloadEmptyDataSet() {
        
        guard let emptyDataView = self.emptyDataView else {
            return
        }
        
        guard cellsCount() == 0 else {
            handlingInvalidEmptyDataSet()
            return
        }
        
        if emptyDataView.superview == nil {
            if (self is UITableView || self is UICollectionView) && subviews.count > 1 {
                insertSubview(emptyDataView, at: 0)
            } else {
                addSubview(emptyDataView)
            }
        }
        
        emptyDataView.isHidden = false
        emptyDataView.clipsToBounds = true
        
        isScrollEnabled = false
        
        emptyDataView.centerXAnchor.constraint(equalTo: emptyDataView.superview!.centerXAnchor).isActive = true
        emptyDataView.centerYAnchor.constraint(equalTo: emptyDataView.superview!.centerYAnchor).isActive = true

        emptyDataView.layoutIfNeeded()
    }
    
    // MARK: - Method swizzling
    fileprivate class func tb_swizzleMethod(for aClass: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
        guard let originalMethod = class_getInstanceMethod(aClass, originalSelector), let swizzledMethod = class_getInstanceMethod(aClass, swizzledSelector) else {
            return
        }
        
        let didAddMethod = class_addMethod(aClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
        
        if didAddMethod {
            class_replaceMethod(aClass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
    
    // swiftlint:disable variable_name
    fileprivate static let tb_swizzleTableViewReloadData: () = {
        let originalSelector = TableViewSelectors.reloadData
        let swizzledSelector = Selectors.tableViewSwizzledReloadData
        
        tb_swizzleMethod(for: UITableView.self, originalSelector: originalSelector, swizzledSelector: swizzledSelector)
    }()
    
    // swiftlint:disable variable_name
    fileprivate static let tb_swizzleTableViewEndUpdates: () = {
        let originalSelector = TableViewSelectors.endUpdates
        let swizzledSelector = Selectors.tableViewSwizzledEndUpdates
        
        tb_swizzleMethod(for: UITableView.self, originalSelector: originalSelector, swizzledSelector: swizzledSelector)
    }()
    
    // swiftlint:disable variable_name
    fileprivate static let tb_swizzleCollectionViewReloadData: () = {
        let originalSelector = CollectionViewSelectors.reloadData
        let swizzledSelector = Selectors.collectionViewSwizzledReloadData
        
        tb_swizzleMethod(for: UICollectionView.self, originalSelector: originalSelector, swizzledSelector: swizzledSelector)
    }()
    
    // swiftlint:disable variable_name
    fileprivate static let tb_swizzleCollectionViewPerformBatchUpdates: () = {
        let originalSelector = CollectionViewSelectors.performBatchUpdates
        let swizzledSelector = Selectors.collectionViewSwizzledPerformBatchUpdates
        
        tb_swizzleMethod(for: UICollectionView.self, originalSelector: originalSelector, swizzledSelector: swizzledSelector)
    }()
    
    @objc
    func tb_tableViewSwizzledReloadData() {
        tb_tableViewSwizzledReloadData()
        reloadEmptyDataSet()
    }
    
    @objc
    func tb_tableViewSwizzledEndUpdates() {
        tb_tableViewSwizzledEndUpdates()
        reloadEmptyDataSet()
    }
    
    @objc
    func tb_collectionViewSwizzledReloadData() {
        tb_collectionViewSwizzledReloadData()
        reloadEmptyDataSet()
    }
    
    @objc
    func tb_collectionViewSwizzledPerformBatchUpdates(_ updates: (() -> Void)?, completion: ((Bool) -> Void)?) {
        tb_collectionViewSwizzledPerformBatchUpdates(updates) { [weak self](completed) in
            completion?(completed)
            self?.reloadEmptyDataSet()
        }
    }
}
