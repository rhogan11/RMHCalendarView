//
//  DateCellConfig.swift
//  Calendar
//
//  Created by Reed Hogan on 10/24/17.
//  Copyright © 2017 Reed Hogan. All rights reserved.
//

import UIKit

public protocol StyleConfigProtocol {
    var textConfig: TextConfigProtocol { get }
    var theme: ThemeProtocol { get }
    var leftCapXibConfig: XibConfig { get }
    var rightCapXibConfig: XibConfig { get }
    var middleXibConfig: XibConfig { get }
    var singleSelectionXibConfig: XibConfig { get }
    var dateCellXibConfig: XibConfig { get }
    func todayView(cellSize: CGSize) -> UIView?
}

struct DefaultStyleNibIds {
    static let leftCap = "LeftCapView"
    static let rightCap = "RightCapView"
    static let middle = "MiddleView"
    static let single = "SingleView"
    static let basic = "DateCell"
}

extension StyleConfigProtocol { //defaults for protocol
    
    public var textConfig: TextConfigProtocol {
        return DefaultTextConfig()
    }
    
    public var theme: ThemeProtocol {
        return Theme()
    }
    
    public var leftCapXibConfig: XibConfig {
        return XibConfig(name: DefaultStyleNibIds.leftCap, resuseIdentifier: DefaultStyleNibIds.leftCap, bundle: Bundle(for: DateCell.self))
    }
    
    public var rightCapXibConfig: XibConfig {
        return XibConfig(name: DefaultStyleNibIds.rightCap, resuseIdentifier: DefaultStyleNibIds.rightCap, bundle: Bundle(for: DateCell.self))
    }
    
    public var middleXibConfig: XibConfig {
        return XibConfig(name: DefaultStyleNibIds.middle, resuseIdentifier: DefaultStyleNibIds.middle, bundle: Bundle(for: DateCell.self))
    }
    
    public var singleSelectionXibConfig: XibConfig {
        return XibConfig(name: DefaultStyleNibIds.single, resuseIdentifier: DefaultStyleNibIds.single, bundle: Bundle(for: DateCell.self))
    }
    
    public var dateCellXibConfig: XibConfig {
        return XibConfig(name: DefaultStyleNibIds.basic, resuseIdentifier: DefaultStyleNibIds.basic, bundle: Bundle(for: DateCell.self))
    }

    public func todayView(cellSize: CGSize) -> UIView? {
        return TodayView(frame: CGRect(origin: CGPoint.zero, size: cellSize), backgroundColor: theme.backgroundColor, borderColor: theme.borderColor, bordeWidth: 2)
    }
}

public class DefaultStyleConfig: StyleConfigProtocol {
    
    let colorTheme: ThemeProtocol
    
    public init(theme: ThemeProtocol = Theme()) {
        self.colorTheme = theme
    }
    
    public var theme: ThemeProtocol {
        return colorTheme
    }
}


