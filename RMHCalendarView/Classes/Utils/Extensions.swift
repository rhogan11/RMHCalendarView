//
//  Extensions.swift
//  Calendar
//
//  Created by Reed Hogan on 10/23/17.
//  Copyright © 2017 Reed Hogan. All rights reserved.
//

import Foundation

extension Date {

    private static func calendar() -> Calendar {
        return Calendar(identifier: .gregorian)
    }
    
    func removeTime() -> Date? {
        let comps = Calendar.current.dateComponents([.year,.month,.day], from: self)
        return Date.calendar().date(from: comps)
    }
    
    func dayString() -> String {
        return "\(Date.calendar().component(.day, from: self))"
    }
    
    func readableString() -> String {
        let dateFormatter = Foundation.DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YY"
        return dateFormatter.string(from: self)
    }
    
    func weekDay() -> Int {
        return Date.calendar().component(.weekday, from: self)
    }
    
    func month() -> Int {
        return Date.calendar().component(.month, from: self)
    }
    
    func monthString() -> String {
        let dateFormatter = Foundation.DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: self)
    }
    
    func sameMonthAsDate(_ date: Date) -> Bool {
        let comp1 = Date.calendar().component(.month, from: self)
        let comp2 = Date.calendar().component(.month, from: date)
        return comp1 == comp2
    }
    
    func sameWeekAsDate(_ date: Date) -> Bool {
        let comp1 = Date.calendar().component(.weekOfYear, from: self)
        let comp2 = Date.calendar().component(.weekOfYear, from: date)
        return comp1 == comp2
    }
    
    func addYears(_ years: Int) -> Date? {
        return Date.calendar().date(byAdding: .year, value: years, to: self)
    }
    
    func addMonths(_ months: Int) -> Date? {
        return Date.calendar().date(byAdding: .month, value: months, to: self)
    }
    
    func addWeeks(_ weeks: Int) -> Date? {
        return Date.calendar().date(byAdding: .weekOfYear, value: weeks, to: self)
    }
    
    func addDays(_ days: Int) -> Date? {
        return Date.calendar().date(byAdding: .day, value: days, to: self)
    }
    
    func endOfMonth() -> Date? {
        guard let oneMonthFromNow = self.addMonths(1) else {
            return nil
        }
        let cal = Date.calendar()
        let newComps = cal.dateComponents([.year, .month], from: oneMonthFromNow)
        return cal.date(from: newComps)?.addingTimeInterval(-1)
    }
    
    func firstOfMonth() -> Date? {
        var comps = Date.calendar().dateComponents([.year,.month,.day], from: self)
        comps.day = 1
        return Date.calendar().date(from: comps)
    }
}

