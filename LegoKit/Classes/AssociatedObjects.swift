//
//  AssociatedObjects.swift
//  LegoKit
//
//  Created by forkon on 2020/2/17.
//

public protocol AssociatedObjects: class {
    func associatedObject<T>(for key: UnsafeRawPointer) -> T?
    func setAssociatedObject<T>(
        _ object: T,
        for key: UnsafeRawPointer,
        policy: AssociationPolicy
    )
}

extension AssociatedObjects {
    func associatedObject<T>(for key: UnsafeRawPointer) -> T? {
        return objc_getAssociatedObject(self, key) as? T
    }

    func setAssociatedObject<T>(
        _ object: T,
        for key: UnsafeRawPointer,
        policy: AssociationPolicy = .strong
    ) {
        return objc_setAssociatedObject(
            self,
            key,
            object,
            policy.objcPolicy
        )
    }
}

public enum AssociationPolicy {
    case strong
    case copy
    case weak

    public var objcPolicy: objc_AssociationPolicy {
        switch self {
        case .strong:
            return .OBJC_ASSOCIATION_RETAIN_NONATOMIC
        case .copy:
            return .OBJC_ASSOCIATION_COPY_NONATOMIC
        case .weak:
            return .OBJC_ASSOCIATION_ASSIGN
       }
    }
}
