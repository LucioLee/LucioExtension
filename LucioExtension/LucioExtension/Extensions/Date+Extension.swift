//
//  Date+Extension.swift
//
//  Created by Lucio on 15/12/23.
//  Copyright © 2016年 Person. All rights reserved.
//

import Foundation
import UIKit

public extension Date {
    
    public var era: Int {
        return NSCalendar.current.component(Calendar.Component.era, from: self)
    }
    public var year: Int {
        return NSCalendar.current.component(Calendar.Component.year, from: self)
    }
    public var month: Int {
        return NSCalendar.current.component(Calendar.Component.month, from: self)
    }
    public var day: Int {
        return NSCalendar.current.component(Calendar.Component.day, from: self)
    }
    public var hour: Int {
        return NSCalendar.current.component(Calendar.Component.hour, from: self)
    }
    public var minute: Int {
        return NSCalendar.current.component(Calendar.Component.minute, from: self)
    }
    public var second: Int {
        return NSCalendar.current.component(Calendar.Component.second, from: self)
    }
    public var weekOfMonth: Int {
        return NSCalendar.current.component(Calendar.Component.weekOfMonth, from: self)
    }
    public var weekOfYear: Int {
        return NSCalendar.current.component(Calendar.Component.weekOfYear, from: self)
    }
    public var weekday: Int {
        return NSCalendar.current.component(Calendar.Component.weekday, from: self)
    }
    public var weekdayOrdinal: Int {
        return NSCalendar.current.component(Calendar.Component.weekdayOrdinal, from: self)
    }
    public var quarter: Int {
        return NSCalendar.current.component(Calendar.Component.quarter, from: self)
    }
    public var nanosecond: Int {
        return NSCalendar.current.component(Calendar.Component.nanosecond, from: self)
    }
    public var timeZone: Int {
        return NSCalendar.current.component(Calendar.Component.timeZone, from: self)
    }
    public var weekDayName: String {
        return self.format("EEEE")
    }
    public var monthName: String {
        return self.format("MMMM")
    }
}
public extension Date {
    
    public static var local: Date {
        let nowDate = Date()
        let timeZone = NSTimeZone.local
        let seconds = timeZone.secondsFromGMT(for: nowDate)
        return nowDate.addingTimeInterval(TimeInterval(seconds))
    }
    
    public static var now: Date {
        return Date()
    }
    
    public static func from(string: String, withFormat dateFormat:String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.locale = NSLocale.current
        return dateFormatter.date(from: string)
    }
    
    public func format(_ dateFormat:String, timeZone: TimeZone = TimeZone.current, locale: Locale = Locale.current) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
    
    public func append(year: Int) -> Date? {
        var components = DateComponents()
        components.year = year
        return self.add(components: components)
    }
    
    public func append(month: Int) -> Date? {
        var components = DateComponents()
        components.month = month
        return self.add(components: components)
    }
    
    public func append(day: Int) -> Date? {
        var components = DateComponents()
        components.day = day
        return self.add(components: components)
    }
    
    public func append(hour: Int) -> Date? {
        var components = DateComponents()
        components.hour = hour
        return self.add(components: components)
    }
    
    public func append(minute: Int) -> Date? {
        var components = DateComponents()
        components.minute = minute
        return self.add(components: components)
    }
    
    public func append(second: Int) -> Date? {
        var components = DateComponents()
        components.minute = second
        return self.add(components: components)
    }
    
    public func add(components: DateComponents) -> Date? {
        var calendar = NSCalendar.current
        calendar.timeZone = NSTimeZone.local
        return calendar.date(byAdding: components, to: self)
    }
}
