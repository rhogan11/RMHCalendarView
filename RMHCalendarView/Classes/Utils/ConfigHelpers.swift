//
//  ConfigHelpers.swift
//  Calendar
//
//  Created by Reed Hogan on 10/26/17.
//  Copyright © 2017 Reed Hogan. All rights reserved.
//

import UIKit


extension UILabel {
    func apply(_ config: TextStyle) {
        self.font = config.font
        self.textColor = config.color
    }
}

extension UIButton {
    func apply(_ config: TextStyle){
        guard let label = self.titleLabel else {return}
        label.apply(config)
    }
}
