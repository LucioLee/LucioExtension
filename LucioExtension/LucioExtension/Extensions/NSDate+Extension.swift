//
//  NSDate+Extension.swift
//
//  Created by Lucio on 15/12/23.
//  Copyright © 2016年 Person. All rights reserved.
//

import Foundation
import UIKit

public extension NSDate {
    
    public var era: Int {
        return NSCalendar.currentCalendar().components(NSCalendarUnit.Era, fromDate: self).era
    }
    public var year: Int {
        return NSCalendar.currentCalendar().components(NSCalendarUnit.Year, fromDate: self).year
    }
    public var month: Int {
        return NSCalendar.currentCalendar().components(NSCalendarUnit.Month, fromDate: self).month
    }
    public var day: Int {
        return NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: self).day
    }
    public var hour: Int {
        return NSCalendar.currentCalendar().components(NSCalendarUnit.Hour, fromDate: self).hour
    }
    public var minute: Int {
        return NSCalendar.currentCalendar().components(NSCalendarUnit.Minute, fromDate: self).minute
    }
    public var second: Int {
        return NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: self).second
    }
    public var weekOfMonth: Int {
        return NSCalendar.currentCalendar().components(NSCalendarUnit.WeekOfMonth, fromDate: self).weekOfMonth
    }
    public var weekOfYear: Int {
        return NSCalendar.currentCalendar().components(NSCalendarUnit.WeekOfYear, fromDate: self).weekOfYear
    }
    public var weekday: Int {
        return NSCalendar.currentCalendar().components(NSCalendarUnit.Weekday, fromDate: self).weekday
    }
    public var weekdayOrdinal: Int {
        return NSCalendar.currentCalendar().components(NSCalendarUnit.WeekdayOrdinal, fromDate: self).weekdayOrdinal
    }
    public var quarter: Int {
        //It seems that there is an issue with the NSCalendarUnit.Quarter being ignored (haven't verified, but did see a bug reported). Anyway, it is simple enough to get around... Just use the NSDateFormatter class
        //return NSCalendar.currentCalendar().components(NSCalendarUnit.Quarter, fromDate: self).quarter
        return Int(self.string(withFormat: "Q"))!
    }
    public var weekDayName:String {
        return self.string(withFormat: "EEEE")
    }
    public var monthName:String {
        return self.string(withFormat:"MMMM")
    }
}

public extension NSDate {
    
    public class func from(dateString:String, WithFormat dateFormat:String) -> NSDate? {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.dateFromString(dateString)
    }
    
    public func string(withFormat dateFormat:String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.stringFromDate(self)
    }
    
    public func local() -> Self {
        let timeZone = NSTimeZone.localTimeZone()
        let seconds = timeZone.secondsFromGMTForDate(self)
        return self.dateByAddingTimeInterval(NSTimeInterval(seconds))
    }
    
    public func append(year year: Int) -> NSDate? {
        let components = NSDateComponents()
        components.year = year
        return self.add(components: components)
    }
    
    public func append(month month: Int) -> NSDate? {
        let components = NSDateComponents()
        components.month = month
        return self.add(components: components)
    }
    
    public func append(day day: Int) -> NSDate? {
        let components = NSDateComponents()
        components.day = day
        return self.add(components: components)
    }
    
    public func append(hour hour: Int) -> NSDate? {
        let components = NSDateComponents()
        components.hour = hour
        return self.add(components: components)
    }
    
    public func append(minute minute: Int) -> NSDate? {
        let components = NSDateComponents()
        components.minute = minute
        return self.add(components: components)
    }
    
    public func append(second second: Int) -> NSDate? {
        let components = NSDateComponents()
        components.minute = second
        return self.add(components: components)
    }
    
    public func add(components components:NSDateComponents) -> NSDate? {
        let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)!
        return calendar.dateByAddingComponents(components, toDate: self, options: NSCalendarOptions(rawValue: 0))
    }
}