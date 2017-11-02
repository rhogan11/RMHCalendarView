//
//  DateCell.swift
//  Calendar
//
//  Created by Reed Hogan on 10/23/17.
//  Copyright © 2017 Reed Hogan. All rights reserved.
//

import UIKit

class DateCell: UICollectionViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    
    var todayView: UIView? {
        didSet {
            guard  let todayView = todayView else { return }
            todayView.frame = self.bounds
            contentView.insertSubview(todayView, belowSubview: dateLabel)

        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        todayView?.removeFromSuperview()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        todayView?.frame = self.bounds
    }
}

