//
//  CalView.swift
//  CalendarView
//
//  Created by Reed Hogan on 10/23/17.
//  Copyright © 2017 Reed Hogan. All rights reserved.
//

import UIKit

public enum SelectionStyle {
    case single, multi
}

public protocol RMHCalendarViewDelegate: class {
    func selectedDateRange(_ dateRange: DateRange)
}

public class RMHCalendarView: UIView {
    
    //uses style
    @discardableResult public static func instantiateOnto(_ view: UIView,
                                withDelegate delegate: RMHCalendarViewDelegate,
                                withSelectionStyle selectionStyle: SelectionStyle = .multi,
                                withRange dateRange: DateRange,
                                withStyle style: StyleConfigProtocol = DefaultStyleConfig(),
                                canSelectPastDates: Bool = true,
                                startingAt selectedDate: Date = Date()) -> RMHCalendarView {
        let calendarView = RMHCalendarView(frame: view.bounds, delegate: delegate, selectionStyle: selectionStyle, dateRange: dateRange, style: style, canSelectPastDates: canSelectPastDates, selectedDate: selectedDate)
        view.addSubview(calendarView)
        return calendarView
    }
    //uses theme
    @discardableResult public static func instantiateOnto(_ view: UIView,
                                                   withDelegate delegate: RMHCalendarViewDelegate,
                                                   withSelectionStyle selectionStyle: SelectionStyle = .multi,
                                                   withRange dateRange: DateRange,
                                                   withTheme theme: ThemeProtocol,
                                                   canSelectPastDates: Bool = true,
                                                   startingAt selectedDate: Date = Date()) -> RMHCalendarView {
        let calendarView = RMHCalendarView(frame: view.bounds, delegate: delegate, selectionStyle: selectionStyle, dateRange: dateRange, theme: theme, canSelectPastDates: canSelectPastDates, selectedDate: selectedDate)
        view.addSubview(calendarView)
        return calendarView
    }
        
    @IBOutlet weak var collectionView: UICollectionView! 
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var sundayLabel: UILabel!
    @IBOutlet weak var mondayLabel: UILabel!
    @IBOutlet weak var tuesdayLabel: UILabel!
    @IBOutlet weak var wednesdayLabel: UILabel!
    @IBOutlet weak var thursdayLabel: UILabel!
    @IBOutlet weak var fridayLabel: UILabel!
    @IBOutlet weak var saturdayLabel: UILabel!
    @IBOutlet weak var backwardsButton: UIButton!
    @IBOutlet weak var forwardsButton: UIButton!

    weak var delegate: RMHCalendarViewDelegate?
    
    private let calendarViewModel: CalendarViewModel
    fileprivate let style: StyleConfigProtocol
    private var incrementState: IncrementState = .unchanged
    
    @IBAction func nextMonth() {
        calendarViewModel.incrementMonth(1)
    }
    
    @IBAction func previousMonth() {
        calendarViewModel.incrementMonth(-1)
    }
    
    private init(frame: CGRect, delegate: RMHCalendarViewDelegate, selectionStyle: SelectionStyle, dateRange: DateRange, style: StyleConfigProtocol, canSelectPastDates: Bool, selectedDate: Date) {
        self.delegate = delegate
        self.calendarViewModel = CalendarViewModel(dateRange: dateRange, selectedDate: selectedDate, canSelectPastDates: canSelectPastDates, selectionStyle: selectionStyle)
        self.style = style
        super.init(frame: frame)
        sharedInit()
    }
    
    private init(frame: CGRect, delegate: RMHCalendarViewDelegate, selectionStyle: SelectionStyle, dateRange: DateRange, theme: ThemeProtocol, canSelectPastDates: Bool, selectedDate: Date) {
        self.delegate = delegate
        self.calendarViewModel = CalendarViewModel(dateRange: dateRange, selectedDate: selectedDate, canSelectPastDates: canSelectPastDates, selectionStyle: selectionStyle)
        self.style = DefaultStyleConfig(theme: theme)
        super.init(frame: frame)
        sharedInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        calendarViewModel = CalendarViewModel(dateRange: DateRange(start: Date(), end: Date()), canSelectPastDates: true, selectionStyle: .multi)
        style = DefaultStyleConfig()
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    func sharedInit() {        
        Bundle(for: RMHCalendarView.self).loadNibNamed("RMHCalendarView", owner: self, options: nil)
        addSubview(container)
        container.frame = self.bounds
        container.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        autoresizingMask = [.flexibleHeight,.flexibleWidth]
        collectionView.register(UINib(nibName: style.dateCellXibConfig.name, bundle: style.dateCellXibConfig.bundle), forCellWithReuseIdentifier: style.dateCellXibConfig.resuseIdentifier)
        collectionView.register(UINib(nibName: style.leftCapXibConfig.name, bundle: style.leftCapXibConfig.bundle), forCellWithReuseIdentifier: style.leftCapXibConfig.resuseIdentifier)
        collectionView.register(UINib(nibName: style.rightCapXibConfig.name, bundle: style.rightCapXibConfig.bundle), forCellWithReuseIdentifier: style.rightCapXibConfig.resuseIdentifier)
        collectionView.register(UINib(nibName: style.middleXibConfig.name, bundle: style.middleXibConfig.bundle), forCellWithReuseIdentifier: style.middleXibConfig.resuseIdentifier)
        collectionView.register(UINib(nibName: style.singleSelectionXibConfig.name, bundle: style.singleSelectionXibConfig.bundle), forCellWithReuseIdentifier: style.singleSelectionXibConfig.resuseIdentifier)
        initViewModelBindings()
        applyStyle()
        monthLabel.text = calendarViewModel.currentMonthText
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.layoutIfNeeded()
        collectionView.reloadData()
        calendarViewModel.resetCal()
    }
    
    private func initViewModelBindings() {
        calendarViewModel.modelsChangedClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.monthLabel.text = self?.calendarViewModel.currentMonthText
            }
        }
        calendarViewModel.scrollToIndexClosure = { [weak self] indexPath, animated in
            DispatchQueue.main.async {
                self?.collectionView.scrollToItem(at: indexPath, at: .top, animated: animated)
            }
        }
        calendarViewModel.updateCalendarDelegate = { [weak self] dateRange in
            guard let dateRange = dateRange else {return}
            self?.delegate?.selectedDateRange(dateRange)
        }
    }
    
    private func applyStyle() {
        monthLabel.apply(style.textConfig.monthTextStyle)
        sundayLabel.apply(style.textConfig.weekDayTextStyle)
        mondayLabel.apply(style.textConfig.weekDayTextStyle)
        tuesdayLabel.apply(style.textConfig.weekDayTextStyle)
        wednesdayLabel.apply(style.textConfig.weekDayTextStyle)
        thursdayLabel.apply(style.textConfig.weekDayTextStyle)
        fridayLabel.apply(style.textConfig.weekDayTextStyle)
        saturdayLabel.apply(style.textConfig.weekDayTextStyle)
        backwardsButton.apply(style.textConfig.monthTextStyle)
        forwardsButton.apply(style.textConfig.monthTextStyle)
    }
}

extension RMHCalendarView { //translate touchevents to indexPaths and pass to viewModel
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        guard let indexPath = collectionView.indexPathForItem(at: touch.location(in: collectionView)) else {
            return
        }
        calendarViewModel.startRange(indexPath)
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        guard let indexPath = collectionView.indexPathForItem(at: touch.location(in: collectionView)) else {
            return
        }
        let currentY = touch.location(in: collectionView).y
        if currentY > collectionView.bounds.maxY && incrementState.rawValue <= 0 {
            debounceScrolling(.forwards)
        } else if currentY < collectionView.bounds.minY && incrementState.rawValue >= 0 {
            debounceScrolling(.backwards)
        }
        calendarViewModel.updateRange(indexPath)
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        incrementState = .unchanged
        guard let touch = touches.first else {return}
        guard let indexPath = collectionView.indexPathForItem(at: touch.location(in: collectionView)) else {
            return
        }
        calendarViewModel.updateRange(indexPath)
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        incrementState = .unchanged
        calendarViewModel.clearSelectedRange()
    }
    
    private func debounceScrolling(_ incrementState: IncrementState) { //prevent user from infinite scrolling
        guard incrementState != .unchanged, calendarViewModel.canScroll else {return}
        self.incrementState = incrementState
        if incrementState == .backwards && !calendarViewModel.canDecrementMonthOnScroll() {
            return //prevent going to previous months before the start of the range
        }
        calendarViewModel.incrementMonth(incrementState.rawValue)
        Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(resetState), userInfo: nil, repeats: false)
        
    }
    @objc func resetState() {
        self.incrementState = .unchanged
    }
}


extension RMHCalendarView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calendarViewModel.numberOfItems
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSizeFor(indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        func dequeuWithIdentifier(_ identifier: String) -> DateCell {
            
            guard let dateCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? DateCell else {
                fatalError("Failed to dequeue cell with Identifier: \(identifier)")
            }
            return dateCell
        }
        
        let viewModel = calendarViewModel.viewModelFor(indexPath)
        var cell: DateCell? = nil
        switch viewModel.selectedStatus {
        case .leftCap:
            cell = dequeuWithIdentifier(style.leftCapXibConfig.resuseIdentifier)
        case .rightCap:
            cell = dequeuWithIdentifier(style.rightCapXibConfig.resuseIdentifier)
        case .middle:
            cell = dequeuWithIdentifier(style.middleXibConfig.resuseIdentifier)
        case .single:
            cell = dequeuWithIdentifier(style.singleSelectionXibConfig.resuseIdentifier)
        default:
            cell = dequeuWithIdentifier(style.dateCellXibConfig.resuseIdentifier)
        }
        guard let dateCell = cell else {
            fatalError("Failed to dequeue DateCell")
        }
        dateCell.dateLabel.text = viewModel.dateString
        if let todayTextStyle = style.textConfig.todayTextStyle, viewModel.isToday {
            dateCell.dateLabel.apply(todayTextStyle)
        } else if let selectedTextStlye = style.textConfig.selectectDateRangeStyle, viewModel.selectedStatus != .none {
            dateCell.dateLabel.apply(selectedTextStlye)
        } else if viewModel.isCurrentMonth {
            dateCell.dateLabel.apply(style.textConfig.currentMonthTextStyle)
        } else {
            dateCell.dateLabel.apply(style.textConfig.nonCurrentMonthTextStyle)
        }
        if viewModel.isToday {
            dateCell.todayView = style.todayView(cellSize: cellSizeFor(indexPath))
        }
        if let lineCell = dateCell as? LineProtocol {
            lineCell.setColorOfLine(style.theme.lineColor)
        }
        return dateCell
    }
    
    private func cellSizeFor(_ indexPath: IndexPath) -> CGSize {
        let roundedWidth = CGFloat(round(collectionView.bounds.width/7))
        let roundedHeight = CGFloat(round((collectionView.bounds.height)/6))
        var height = roundedHeight
        var width = roundedWidth
        if indexPath.item%7 == 6 {
            width = collectionView.bounds.width - (roundedWidth * 6)
        }
        if indexPath.item/7 == 5 {
            height = collectionView.bounds.height - (roundedHeight * 5)
        }
        return CGSize(width: width, height: height)
    }
}

