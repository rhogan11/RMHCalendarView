//
//  DateRange.swift
//  Calendar
//
//  Created by Reed Hogan on 10/24/17.
//  Copyright © 2017 Reed Hogan. All rights reserved.
//

import Foundation

open class DateRange {
    
    public var start: Date
    public var end: Date
    
    public init(start: Date, end: Date) {
        self.start = start
        self.end = end
    }
}
