//
//  ThemeController.swift
//  RMHCalendarView_Example
//
//  Created by Reed Hogan on 11/2/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import RMHCalendarView


class ThemeController: BaseController {
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar = RMHCalendarView.instantiateOnto(calendarContainer,
                                                   withDelegate: self,
                                                   withSelectionStyle: .multi,
                                                   withRange: dateRange,
                                                   withTheme: ThemeConfig(), //pass in theme instance
                                                   canSelectPastDates: true,
                                                   startingAt: Date())
    }
}

//CUSTOM THEME OVERRIDING THE THEMEPROTOCOLS DEFAULT IMPLEMENTATION
class ThemeConfig: ThemeProtocol {
    var backgroundColor: UIColor {
        return UIColor(red: (158/255), green: (113/255), blue: (168/255), alpha: (255/255))
    }
    
    var borderColor: UIColor {
        return UIColor(red: (99/255), green: (39/255), blue: (112/255), alpha: (255/255))
    }
    
    var lineColor: UIColor {
        return UIColor(red: (178/255), green: (133/255), blue: (198/255), alpha: (100/255))
    }
}
