//
//  ExampleStyleController.swift
//  RMHCalendarView_Example
//
//  Created by Reed Hogan on 11/2/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import RMHCalendarView

class StyleController: BaseController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar = RMHCalendarView.instantiateOnto(calendarContainer,
                                                   withDelegate: self,
                                                   withSelectionStyle: .multi,
                                                   withRange: dateRange,
                                                   withStyle: ExampleStyleConfig(), //pass in an instance of the config here
                                                   canSelectPastDates: true,
                                                   startingAt: Date())
    }
}

//CUSTOM CONFIGS OVERRIDING THE PROTOCOLS DEFAULT IMPLEMENTATIONS
class ExampleTextConfig: TextConfigProtocol {
    var currentMonthTextStyle: TextStyle {
        return TextStyle(font: .systemFont(ofSize: 18), color: .black)
    }
    
    var nonCurrentMonthTextStyle: TextStyle {
        return TextStyle(font: .italicSystemFont(ofSize: 16), color: .lightGray)
    }
    
    var todayTextStyle: TextStyle? {
        return nil //prevent today's text style from being different
    }
    
    var selectectDateRangeStyle: TextStyle? {
        return TextStyle(font: .systemFont(ofSize: 18, weight: .bold), color: .white)
    }
    
    var monthTextStyle: TextStyle {
        return TextStyle(font: .systemFont(ofSize: 24, weight: .bold), color: .black)
    }
    
    var weekDayTextStyle: TextStyle {
        return TextStyle(font: .systemFont(ofSize: 18), color: .black)
    }
}

class ExampleStyleConfig: StyleConfigProtocol {
    var textConfig: TextConfigProtocol {
        return ExampleTextConfig()
    }
    
    public var leftCapXibConfig: XibConfig {
        return XibConfig(name: "ExampleLeftCap", resuseIdentifier: "ExampleLeftCap")
    }
    
    public var rightCapXibConfig: XibConfig {
        return XibConfig(name: "ExampleRightCap", resuseIdentifier: "ExampleRightCap")
    }
    
    public var middleXibConfig: XibConfig {
        return XibConfig(name: "ExampleMiddleView", resuseIdentifier: "ExampleMiddleView")
    }
    
    public var singleSelectionXibConfig: XibConfig {
        return XibConfig(name: "ExampleSingleSelection", resuseIdentifier: "ExampleSingleSelection")
    }
    
    func todayView(cellSize: CGSize) -> UIView? {
        return nil //returning nil shows nothing for the today view
    }
}
