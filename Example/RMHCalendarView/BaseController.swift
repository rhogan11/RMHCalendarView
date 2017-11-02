//
//  BaseController.swift
//  RMHCalendarView_Example
//
//  Created by Reed Hogan on 11/1/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import RMHCalendarView

class BaseController: UIViewController, RMHCalendarViewDelegate {
    @IBOutlet weak var calendarContainer: UIView!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    
    lazy var dateRange: DateRange = {
        guard let start = Date().addYears(-1), let end = Date().addYears(1) else {
            return DateRange(start: Date(), end: Date())
        }
        return DateRange(start: start, end: end)
    }()
    
    
    var calendar: RMHCalendarView?

    func selectedDateRange(_ dateRange: DateRange) {
        startLabel.text = "Date Range Start: \(dateRange.start)"
        endLabel.text = "Date Range End: \(dateRange.end)"
    }
    
}

extension Date {
    func addYears(_ years: Int) -> Date? {
        return Calendar.current.date(byAdding: .year, value: years, to: self)
    }
}

