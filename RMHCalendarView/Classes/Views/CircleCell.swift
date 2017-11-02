//
//  LeftCapView.swift
//  Calendar
//
//  Created by Reed Hogan on 10/30/17.
//  Copyright © 2017 Reed Hogan. All rights reserved.
//

import UIKit

protocol LineProtocol {
    func setColorOfLine(_ color: UIColor)
}

class CircleCell: DateCell {

    private lazy var circle: UIView = {
        return UIView()
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateLayout()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        circle.layer.borderColor = UIColor.black.cgColor
        circle.layer.borderWidth = 2
        circle.backgroundColor = .white
        contentView.insertSubview(circle, belowSubview: dateLabel)
        updateLayout()
    }
    
    private func updateLayout() {
        let side = min(bounds.width, bounds.height)
        circle.layer.cornerRadius = side/2
        circle.frame = CGRect(x: 0, y: 0, width: side, height: side)
        circle.center = contentView.center
    }
}


class CircleAndLineCell: CircleCell, LineProtocol {
    @IBOutlet weak var lineView: UIView!
    
    func setColorOfLine(_ color: UIColor) {
        lineView.backgroundColor = color
    }
}

class LineCell: DateCell, LineProtocol {
    @IBOutlet weak var lineView: UIView!
    
    func setColorOfLine(_ color: UIColor) {
        lineView.backgroundColor = color
    }
}
