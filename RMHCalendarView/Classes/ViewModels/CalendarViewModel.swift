//
//  CalendarViewModel.swift
//  Calendar
//
//  Created by Reed Hogan on 10/23/17.
//  Copyright © 2017 Reed Hogan. All rights reserved.
//

import Foundation


public class CalendarViewModel {

     var selectedDateRange: DateRange?
     var currentMonthDate: Date
     let boundsDateRange: DateRange
     let canSelectPastDates: Bool
     let selectionStyle: SelectionStyle
     var dates = [Date]()
     var lastSelectedIndex: IndexPath?
     var dateModels = [DateCellViewModel]()
    
    var numberOfItems: Int {
        return dateModels.count
    }
    var numberOfSections: Int {
        return 1
    }
    var currentMonthText: String {
        return currentMonthDate.monthString()
    }
    var canScroll: Bool  {
        return selectionStyle == .multi
    }
    var modelsChangedClosure: (() -> Void)?
    var scrollToIndexClosure: ((IndexPath, Bool) -> Void)?
    var updateCalendarDelegate: ((DateRange?) -> Void)?
    
    init(dateRange: DateRange, selectedDate: Date = Date(), canSelectPastDates: Bool, selectionStyle: SelectionStyle) {
        self.selectionStyle = selectionStyle
        self.boundsDateRange = DateRange(start: dateRange.start.removeTime() ?? dateRange.start, end: dateRange.end.removeTime() ?? dateRange.end)
        self.canSelectPastDates = canSelectPastDates
        self.currentMonthDate = selectedDate
        guard
            let adjSelected = selectedDate.firstOfMonth(),
            let firstOfMonth = dateRange.start.firstOfMonth(),
            let adjFirst = firstOfMonth.addDays(1-firstOfMonth.weekDay()),
            let inputEnd = dateRange.end.endOfMonth(),
            let adjEnd = inputEnd.addDays(7-inputEnd.weekDay()) else {return}
        guard adjFirst < adjEnd  else {
            print("Invalid Date Range for calendard - start date may not be before end date")
            return
        }
        var dateToAdd = adjFirst
        while dateToAdd <= adjEnd {
            dates.append(dateToAdd)
            guard let newDate = dateToAdd.addDays(1) else {break}
            dateToAdd = newDate
        }
        currentMonthDate = dates.contains(where: {$0 == adjSelected}) ? adjSelected : firstOfMonth
        buildModelViews()
    }
    
    func viewModelFor(_ indexPath: IndexPath) -> DateCellViewModel {
        return dateModels[indexPath.item]
    }
    
    func resetCal() {
        guard let item = dates.index(where: {$0 == currentMonthDate}) else {return}
        scrollToIndexClosure?(IndexPath(item: item, section: 0), false)
    }
    
    func incrementMonth(_ delta: Int) {
        guard
            let firstOfNewMonth = currentMonthDate.firstOfMonth()?.addMonths(delta),
            let endOfNewMonth = firstOfNewMonth.endOfMonth()?.removeTime(),
            let item = dates.index(where: {$0 == firstOfNewMonth}),
            dates.contains(firstOfNewMonth) && dates.contains(endOfNewMonth) else {return}
        currentMonthDate = firstOfNewMonth
        scrollToIndexClosure?(IndexPath(item: item, section: 0), true)
        buildModelViews()
    }
    
    private func buildModelViews() {
        dateModels = dates.map(){dateCellViewModelFrom($0)}
        modelsChangedClosure?()
    }
    
    private func reloadModelViewsAtIndexPaths(_ indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            dateModels[indexPath.item] = dateCellViewModelFrom(dates[indexPath.item])
        }
        modelsChangedClosure?()
    }
    
    private func dateCellViewModelFrom(_ date: Date) -> DateCellViewModel {
        var selectedStatus: SelectedStatus = .none
        if let dateRange = selectedDateRange {
            if dateRange.start == date {
                selectedStatus = dateRange.end == date ? .single : .leftCap
            } else if dateRange.end == date {
                selectedStatus = .rightCap
            } else if date > dateRange.start && date < dateRange.end {
                selectedStatus = .middle
            }
        }
        return DateCellViewModel(isToday: date == Date().removeTime(),
                                 selectedStatus: selectedStatus,
                                 isCurrentMonth: date.sameMonthAsDate(currentMonthDate),
                                 dateString: date.dayString())
    }
    
    func canDecrementMonthOnScroll() -> Bool { //only allows going to previous month when selection started there
        if let start = selectedDateRange?.start {
            return currentMonthDate >= start
        }
        return false
    }
}


extension CalendarViewModel { //process touches
    func startRange(_ indexPath: IndexPath) {
        let start = dates[indexPath.item]
        guard start >= boundsDateRange.start && start <= boundsDateRange.end else { return }
        guard let current = Date().removeTime(), canSelectPastDates || start >= current else {return}
        lastSelectedIndex = indexPath
        selectedDateRange = DateRange(start: start, end: start)
        updateCalendarDelegate?(selectedDateRange)
        buildModelViews()
    }
    
    func updateRange(_ endIndex: IndexPath) {
        guard let dateRange = selectedDateRange else {return} //if there is no current range, update is invalid
        guard let last = lastSelectedIndex else {return} //if there is no last, update is also invalid
        let date = dates[endIndex.item]
        guard date >= boundsDateRange.start && date <= boundsDateRange.end else { return }
        let start = selectionStyle == .single ? date : dateRange.start
        let end = date <= dateRange.start && selectionStyle == .multi ? dateRange.start : date //dont let multi selection drag earlier than start date
        guard end != dateRange.end else {
            return // dont call delegate unless dateRange has changed
        }
        self.selectedDateRange = DateRange(start: start, end: end)
        updateCalendarDelegate?(selectedDateRange)
        reloadModelViewsAtIndexPaths(indexPathsFromRange(index1: last, index2: endIndex))
        lastSelectedIndex = endIndex
    }
    
    func clearSelectedRange() {
        lastSelectedIndex = nil
        selectedDateRange = nil
    }
    
    func indexPathsFromRange(index1: IndexPath, index2: IndexPath) -> [IndexPath]{
        var indexPaths = [IndexPath]()
        //sort to ensure the first is smaller
        let start = index1.item < index2.item ? index1 : index2
        let end = start.item == index1.item ? index2 : index1
        for item in start.item...end.item {
            indexPaths.append(IndexPath(item: item, section: 0))
        }
        return indexPaths
    }
}
