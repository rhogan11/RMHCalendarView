//
//  DefaultController.swift
//  RMHCalendarView_Example
//
//  Created by Reed Hogan on 11/1/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import RMHCalendarView

class DefaultController: BaseController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar = RMHCalendarView.instantiateOnto(calendarContainer,
                                                   withDelegate: self,
                                                   withRange: dateRange)
    }

}



