//
//  TodayView.swift
//  Calendar
//
//  Created by Reed Hogan on 10/31/17.
//  Copyright © 2017 Reed Hogan. All rights reserved.
//

import UIKit

class TodayView: UIView {
    
    private let circleBackgroundColor: UIColor
    private let borderColor: CGColor
    private let borderWidth: CGFloat
    
    private lazy var circle: UIView = {
        return UIView()
    }()
    
     init(frame: CGRect, backgroundColor: UIColor, borderColor: UIColor, bordeWidth: Int = 2) {
        self.borderWidth = CGFloat(bordeWidth)
        self.borderColor = borderColor.cgColor
        self.circleBackgroundColor = backgroundColor
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateLayout()
    }
    
    private func setupView() {
        circle.layer.borderColor = borderColor
        circle.layer.borderWidth = borderWidth
        circle.backgroundColor = circleBackgroundColor
        addSubview(circle)
        updateLayout()
    }
    
    private func updateLayout() {
        let side = min(bounds.width, bounds.height)
        circle.layer.cornerRadius = side/2
        circle.frame = CGRect(x: 0, y: 0, width: side, height: side)
        circle.center = center
    }    
}
