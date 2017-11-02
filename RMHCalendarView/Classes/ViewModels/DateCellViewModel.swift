//
//  DateCellViewModel.swift
//  Calendar
//
//  Created by Reed Hogan on 10/23/17.
//  Copyright © 2017 Reed Hogan. All rights reserved.
//

import Foundation

struct DateCellViewModel {
    let isToday: Bool
    let selectedStatus: SelectedStatus
    let isCurrentMonth: Bool
    let dateString: String
}

enum SelectedStatus {
    case leftCap, rightCap, middle, single, none
}
