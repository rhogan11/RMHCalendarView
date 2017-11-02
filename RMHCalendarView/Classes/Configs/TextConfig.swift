//
//  TextConfig.swift
//  Calendar
//
//  Created by Reed Hogan on 10/26/17.
//  Copyright © 2017 Reed Hogan. All rights reserved.
//

import UIKit

public protocol TextConfigProtocol {
    var todayTextStyle: TextStyle? { get }
    var currentMonthTextStyle: TextStyle { get }
    var nonCurrentMonthTextStyle: TextStyle { get }
    var weekDayTextStyle: TextStyle { get }
    var monthTextStyle: TextStyle { get }
    var selectectDateRangeStyle: TextStyle? { get }
}

extension TextConfigProtocol { //defaults for protocol
    public var todayTextStyle: TextStyle? {
        return TextStyle(font: UIFont.systemFont(ofSize: 14, weight: .thin), color: UIColor.white)
    }
    public var currentMonthTextStyle: TextStyle {
        return TextStyle(font: UIFont.systemFont(ofSize: 16, weight: .thin), color: UIColor.black)
    }
    public var nonCurrentMonthTextStyle: TextStyle {
        return TextStyle(font: UIFont.systemFont(ofSize: 14, weight: .thin), color: UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1))
    }
    public var weekDayTextStyle: TextStyle {
        return TextStyle(font: UIFont.systemFont(ofSize: 18, weight: .thin), color: UIColor.black)
    }
    public var monthTextStyle: TextStyle {
        return TextStyle(font: UIFont.systemFont(ofSize: 22, weight: .thin), color: UIColor.black)
    }
    public var selectectDateRangeStyle: TextStyle? {
        return TextStyle(font: UIFont.systemFont(ofSize: 16, weight: .thin), color: .black)
    }
}

open class DefaultTextConfig: TextConfigProtocol {//uses protocol defaults
    public init(){}
}
