//
//  Tuple2Array.swift
//  LegoKit
//
//  Created by forkon on 2018/12/12.
//

/// Examples:
///
/// var t = (1,2,3,4,5,6,7,8)
/// let arr:[Int] = arrayFromTuple(t)
/// print(arr) // [1, 2, 3, 4, 5, 6, 7, 8]
///
/// let t2 = ("alfa","beta","gama")
/// let arr2:[String] = arrayFromTuple(t2)
/// arr2[1] // "beta"
///
func arrayFromTuple<T,R>(tuple: T) -> [R] {
    let reflection = Mirror(reflecting: tuple)
    var array: [R] = []
    for i in reflection.children {
        // better will be to throw an Error if i.value is not R
        array.append(i.value as! R)
    }
    return array
}

func stringArrayFromCStringArray(cStringArray: [UnsafePointer<UInt8>]) -> [String] {
    return cStringArray.map{String(cString: $0)}
}
