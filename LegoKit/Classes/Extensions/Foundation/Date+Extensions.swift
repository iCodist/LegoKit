//
//  Date+Extensions.swift
//  LegoKit
//
//  Created by forkon on 2018/10/29.
//

import UIKit

extension Date {
    
    public var Year: Int {
        let curCalendar:Calendar = Calendar.current
        let componentYear:Int = (curCalendar as NSCalendar).component(NSCalendar.Unit.year, from: self)
        return componentYear
    }
    
    public var Month: Int {
        let curCalendar:Calendar = Calendar.current
        let componentMonth:Int = (curCalendar as NSCalendar).component(NSCalendar.Unit.month, from: self)
        return componentMonth
    }
    
    public var Day: Int {
        let curCalendar:Calendar = Calendar.current
        let componentDay:Int = (curCalendar as NSCalendar).component(NSCalendar.Unit.day, from: self)
        return componentDay
    }
    
    public func isSameDay(_ dateToCmp:Date) -> Bool {
        var isSameDay = false
        
        if  (self.Year == dateToCmp.Year) &&
            (self.Month == dateToCmp.Month) &&
            (self.Day == dateToCmp.Day) {
            isSameDay = true
        }
        
        return isSameDay
    }
    
}
